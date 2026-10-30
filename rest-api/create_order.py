"""
Priority ERP REST API (OData) - create a sales order with lines in one POST.

Requires: Python 3.8+ and the requests package
    pip install requests
    python create_order.py

The order header and its lines (ORDERITEMS_SUBFORM) are sent together,
exactly like a user filling the Sales Orders form - so all form triggers
(validations, default values, prices) run as usual.

More on Priority API integrations: https://www.skdevelop.co.il/post/priority-api
"""

import requests

# ---- Settings: replace with your own values ----
SERVER = "https://your-priority-server.com"
INI = "tabula.ini"
COMPANY = "demo"
USER = "apiuser"        # or a Personal Access Token
PASSWORD = "secret"     # with a PAT the password is "PAT"

BASE = f"{SERVER}/odata/Priority/{INI}/{COMPANY}"


def create_order(customer, lines):
    payload = {
        "CUSTNAME": customer,
        "ORDERITEMS_SUBFORM": [
            {"PARTNAME": part, "TQUANT": qty} for part, qty in lines
        ],
    }
    res = requests.post(
        f"{BASE}/ORDERS",
        json=payload,
        auth=(USER, PASSWORD),
        headers={"Accept": "application/json"},
        timeout=60,
    )
    if not res.ok:
        # Form trigger errors (e.g. "customer is frozen") come back in the body
        raise RuntimeError(f"HTTP {res.status_code}: {res.text}")
    return res.json()["ORDNAME"]  # the new order number


if __name__ == "__main__":
    order_no = create_order("C1000", [("P100", 2), ("P200", 1)])
    print("Created order", order_no)
