# Priority ERP – Code Examples (REST API & SQLI)

Practical, ready-to-adapt examples for **Priority ERP** (Priority Zoom / Priority Pro):
reading and creating documents through the Priority REST API (OData), and common SQLI
patterns for reports and form triggers.

Maintained by **[S.K. Develop](https://www.skdevelop.co.il)** – Priority ERP implementation,
development, integrations and support in Israel.

## Contents

| Folder | File | What it shows |
| --- | --- | --- |
| `rest-api` | `get-orders.js` | Read sales orders + lines with `$filter`, `$select`, `$expand` (Node.js) |
| `rest-api` | `create_order.py` | Create a sales order with lines in one POST (Python) |
| `sqli` | `orders-last-30-days.sql` | Report query: outer join, date arithmetic, key-0 records |
| `sqli` | `check-field-example.sql` | CHECK-FIELD trigger with a custom error message |

## Before you start

- REST API: you need the API URL of your Priority server, the company name and a user
  (or a Personal Access Token) that has privileges on the forms you call.
- SQLI: run queries in **WINDBI** first. Replace the `XXXX_` prefix with your own
  four-letter customization prefix.
- Column names can differ between versions and customizations – check them in the
  form / table dictionary before using in production.

## Learn more (Hebrew)

- [Priority API – connecting Priority to websites, POS and external systems](https://www.skdevelop.co.il/post/priority-api)
- [Priority development – automation, API, reports and customizations](https://www.skdevelop.co.il/develop)
- [What is Priority ERP and who is it for](https://www.skdevelop.co.il/priority-erp)
- [Priority implementation step by step](https://www.skdevelop.co.il/post/priority-implementation)

---

## בעברית

מאגר דוגמאות קוד מעשיות לפריוריטי: עבודה עם ה-REST API של פריוריטי (קריאה ויצירה של
מסמכים), ושאילתות SQLI נפוצות לדוחות ולטריגרים.

המאגר מתוחזק על ידי **[S.K. Develop](https://www.skdevelop.co.il)**: יישום, פיתוח,
ממשקים ותמיכה במערכת פריוריטי (Priority ERP).

צריכים ממשק לפריוריטי, פיתוח מותאם או ייעוץ? [צרו קשר](https://www.skdevelop.co.il/blank-5) –
שיחת ייעוץ ראשונית ללא עלות.

## License

MIT – free to use and adapt.
