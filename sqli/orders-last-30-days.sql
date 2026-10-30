/*
  Priority SQLI - sales orders from the last 30 days, with the agent (if any).
  Run in WINDBI (SQL interpreter) or use inside a procedure SQLI step.

  Shows three Priority-specific patterns:
  1. Date arithmetic: dates are stored as minutes, so N days = 24:00 * N
  2. Outer join: a "?" after the optional table (instead of LEFT JOIN)
  3. Key-0 records: standard tables have an empty record with key 0 - exclude it

  More on Priority development: https://www.skdevelop.co.il/develop
*/

SELECT ORDERS.ORDNAME, DTOA(ORDERS.CURDATE, 'DD/MM/YY') AS ORDDATE,
       CUSTOMERS.CUSTNAME, CUSTOMERS.CUSTDES,
       (AGENTS.AGENT = 0 ? '-' : AGENTS.AGENTNAME) AS AGENT  /* Priority conditional, not CASE */
FROM ORDERS, CUSTOMERS, AGENTS ?                          /* AGENTS is optional (outer join) */
WHERE ORDERS.CUST = CUSTOMERS.CUST
AND   ORDERS.AGENT = AGENTS.AGENT
AND   ORDERS.ORD <> 0                                     /* skip the key-0 record */
AND   ORDERS.CURDATE >= SQL.DATE8 - 24:00 * 30            /* last 30 days */
ORDER BY ORDERS.CURDATE DESC
FORMAT;
