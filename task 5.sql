CREATE DATABASE IF NOT EXISTS order_management;
USE order_management;

CREATE TABLE Payment (
    Payment_ID INT PRIMARY KEY,
    Order_ID INT NOT NULL UNIQUE,
    Payment_Date DATE NOT NULL,
    Payment_Mode VARCHAR(30) NOT NULL,
    Payment_Status VARCHAR(20) NOT NULL DEFAULT 'Pending',
    Transaction_Amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    CHECK (Payment_Mode IN (
        'UPI', 'Credit Card', 'Debit Card',
        'Net Banking', 'Cash on Delivery'
    )),
    CHECK (Payment_Status IN ('Pending', 'Success', 'Failed')),
    CHECK (Transaction_Amount > 0)
);

INSERT INTO Payment VALUES
(501, 301, '2026-10-20', 'UPI', 'Success', 1550.00),
(502, 302, '2026-10-21', 'Credit Card', 'Success', 2300.00),
(503, 303, '2026-10-22', 'Debit Card', 'Failed', 2200.00),
(504, 304, '2026-10-23', 'Net Banking', 'Pending', 1500.00);

SELECT * FROM Payment;

INSERT INTO Payment VALUES
(505, 305, '2026-10-24', 'Cash on Delivery', 'Pending', 1650.00);

UPDATE Payment
SET Payment_Mode = 'UPI'
WHERE Payment_ID = 504;

UPDATE Payment
SET Payment_Status = 'Success'
WHERE Payment_ID = 503;

SELECT * FROM Payment
WHERE Payment_Status = 'Success';

SELECT * FROM Payment
WHERE Payment_Status = 'Failed';

SELECT * FROM Payment
WHERE Payment_Status = 'Pending';

SELECT * FROM Payment
WHERE Order_ID = 301;

SELECT COUNT(*) AS Total_Payments
FROM Payment;

SELECT Payment_Status, COUNT(*) AS Total
FROM Payment
GROUP BY Payment_Status;

SELECT Payment_Mode, COUNT(*) AS Total_Transactions
FROM Payment
GROUP BY Payment_Mode;

SELECT Payment_Mode, SUM(Transaction_Amount) AS Total_Amount
FROM Payment
WHERE Payment_Status = 'Success'
GROUP BY Payment_Mode;

SELECT SUM(Transaction_Amount) AS Total_Revenue
FROM Payment
WHERE Payment_Status = 'Success';

SELECT AVG(Transaction_Amount) AS Average_Transaction
FROM Payment;

SELECT MAX(Transaction_Amount) AS Highest_Transaction
FROM Payment;

SELECT MIN(Transaction_Amount) AS Lowest_Transaction
FROM Payment;

SELECT P.Payment_ID, P.Order_ID, P.Payment_Date,
       P.Payment_Mode, P.Payment_Status, P.Transaction_Amount
FROM Payment P
JOIN Orders O ON P.Order_ID = O.Order_ID;

DELETE FROM Payment
WHERE Payment_ID = 505;

SELECT * FROM Payment;