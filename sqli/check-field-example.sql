/*
  Priority SQLI - CHECK-FIELD trigger example.

  Goal: on the order lines form (ORDERITEMS), block a quantity above
  a maximum, and show the maximum in the error message.

  Setup:
  1. Form Generator -> ORDERITEMS -> Form Columns -> TQUANT -> Form Column Triggers
  2. Add a trigger named XXXX_CHECK-FIELD (replace XXXX with your 4-letter prefix)
  3. In Error & Warning Messages add message 501:
       Quantity cannot exceed <P1> units
     (custom messages must be > 500; keep Hebrew text in the message, not in code)

  Notes:
  - CHECK-FIELD fires only when the user changes the value.
  - REALQUANT converts the shifted-integer quantity to a real number.
  - :XXXX_MAXQTY is REAL (1000.0) so it compares cleanly with REALQUANT.
  - :PAR1 is CHAR, so the number is converted with RTOA.

  More on Priority development: https://www.skdevelop.co.il/develop
*/

:XXXX_MAXQTY = 1000.0;

GOTO 9999 WHERE REALQUANT(:$.@) <= :XXXX_MAXQTY;

:PAR1 = RTOA(:XXXX_MAXQTY, 0);
ERRMSG 501;

LABEL 9999;
