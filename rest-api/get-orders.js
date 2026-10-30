/**
 * Priority ERP REST API (OData) – read sales orders with their lines.
 *
 * Runs on Node.js 18+ (built-in fetch). No packages needed.
 *   node get-orders.js
 *
 * More on Priority API integrations: https://www.skdevelop.co.il/post/priority-api
 */

// ---- Settings: replace with your own values ----
const SERVER = "https://your-priority-server.com"; // Priority Web / Cloud host
const INI = "tabula.ini";                           // usually tabula.ini
const COMPANY = "demo";                             // company (environment) name
const USER = "apiuser";                             // or a Personal Access Token
const PASSWORD = "secret";                          // with a PAT the password is "PAT"

const BASE = `${SERVER}/odata/Priority/${INI}/${COMPANY}`;
const AUTH = "Basic " + Buffer.from(`${USER}:${PASSWORD}`).toString("base64");

async function getRecentOrders(fromDate) {
  // OData query options:
  // $select - only the columns you need (faster responses)
  // $filter - server-side filter (dates in ISO format)
  // $expand - include a sub-level form (order lines) in the same call
  // $top    - limit the number of records
  const query = new URLSearchParams({
    $select: "ORDNAME,CUSTNAME,CURDATE",
    $filter: `CURDATE ge ${fromDate}`,
    $expand: "ORDERITEMS_SUBFORM($select=PARTNAME,TQUANT,PRICE)",
    $top: "20",
  });

  const res = await fetch(`${BASE}/ORDERS?${query}`, {
    headers: { Authorization: AUTH, Accept: "application/json" },
  });

  if (!res.ok) {
    // Priority returns the error text in the body (privileges, bad column name, etc.)
    throw new Error(`HTTP ${res.status}: ${await res.text()}`);
  }

  const data = await res.json();
  return data.value; // OData returns the records in "value"
}

getRecentOrders("2026-01-01T00:00:00Z")
  .then((orders) => {
    for (const o of orders) {
      console.log(`${o.ORDNAME}  ${o.CUSTNAME}  ${o.CURDATE}`);
      for (const line of o.ORDERITEMS_SUBFORM || []) {
        console.log(`   ${line.PARTNAME}  qty ${line.TQUANT}  price ${line.PRICE}`);
      }
    }
  })
  .catch((err) => console.error(err.message));
