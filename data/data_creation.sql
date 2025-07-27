-- Create the database
CREATE DATABASE Power_BI;
GO

-- Use the new database
USE Power_BI;
GO

-- Drop tables if they exist (in FK-safe order)
IF OBJECT_ID('Transactions', 'U') IS NOT NULL DROP TABLE Transactions;
IF OBJECT_ID('Accounts', 'U') IS NOT NULL DROP TABLE Accounts;
IF OBJECT_ID('Customers', 'U') IS NOT NULL DROP TABLE Customers;
GO

-- Create Customers Table
CREATE TABLE Customers (
    CustomerID     INT PRIMARY KEY,
    Name           NVARCHAR(100),
    Gender         VARCHAR(10) NULL,
    DateOfBirth    VARCHAR(20),
    Address        NVARCHAR(200) NULL,
    Email          NVARCHAR(100) NULL,
    Phone          VARCHAR(20),
    AccountID      INT
);
GO

-- Create Accounts Table
CREATE TABLE Accounts (
    AccountID   INT PRIMARY KEY,
    CustomerID  INT,
    Type        NVARCHAR(20),
    OpenDate    VARCHAR(20),
    Balance     DECIMAL(18,2)
);
GO

-- Create Transactions Table
CREATE TABLE Transactions (
    TransactionID    INT,
    AccountID        INT,
    TransactionDate  VARCHAR(20),
    Type             VARCHAR(20),
    Amount           DECIMAL(18,2),
    Description      NVARCHAR(200) NULL,
    Currency         VARCHAR(10)
);
GO

-- Insert Customers
INSERT INTO Customers (CustomerID, Name, Gender, DateOfBirth, Address, Email, Phone, AccountID) VALUES
(1, 'Ajay Sharma', 'M', '1980-11-04', '123 Main St', NULL, '9891000001', 101),
(2, 'priya singh', NULL, '21-07-1975', '22B Park Road', 'priya@sample.com', '9891000002', 102),
(3, 'Sarah Khan', 'F', '1989/02/20', '', 'sarahkhan@email.com', '9891000003', 103),
(4, 'Mark Lee', 'M', '1995-05-14', '456 North Rd', 'markl@email.com', '9891000004', 104),
(5, 'NAdea KUmar', 'F', '04-12-1982', NULL, NULL, '9891000005', 105);
GO

-- Insert Accounts
INSERT INTO Accounts (AccountID, CustomerID, Type, OpenDate, Balance) VALUES
(101, 1, 'SAVINGS',    '03/14/2013',    10000.00),
(102, 2, 'current',    '2011-06-20',  -157874.40),
(103, 3, 'Savings',    '2019/11/02',      0.00),
(104, 4, 'CURRENT',    '21-07-2018',     50.00),
(105, 99, 'Savings',   '07-05-2016',     14.75);  -- Invalid CustomerID
GO

-- Insert 10,000 synthetic Transactions
;WITH NumberedRows AS (
    SELECT 
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn
    FROM
        sys.all_objects a
        CROSS JOIN sys.all_columns c
)
INSERT INTO Transactions (
    TransactionID, AccountID, TransactionDate, Type, Amount, Description, Currency
)
SELECT
    100000 + rn AS TransactionID,
    CASE WHEN rn % 20 = 0 THEN 9999 ELSE 101 + (rn % 100) END AS AccountID,
    CASE 
        WHEN rn % 3 = 0 THEN FORMAT(DATEADD(DAY, -rn % 365, GETDATE()), 'yyyy/MM/dd')
        ELSE CONVERT(VARCHAR(10), DATEADD(DAY, -rn % 365, GETDATE()), 105)
    END AS TransactionDate,
    CASE WHEN rn % 2 = 0 THEN 'Credit' ELSE 'DEBIT' END AS Type,
    CASE 
        WHEN rn % 1000 = 0 THEN -99999.99
        WHEN rn % 250 = 0 THEN 1000000.99
        ELSE (ABS(CHECKSUM(NEWID())) % 5000) *
             CASE WHEN rn % 2 = 0 THEN 1 ELSE -1 END 
    END AS Amount,
    CASE 
        WHEN rn % 50 = 0 THEN NULL
        ELSE CASE WHEN rn % 2 = 0 THEN 'payment' ELSE 'Salary Credit' END
    END AS Description,
    CASE 
        WHEN rn % 3 = 0 THEN 'usd'
        WHEN rn % 5 = 0 THEN 'INR'
        ELSE 'USD'
    END AS Currency
FROM NumberedRows
WHERE rn <= 10000;
GO

-- Optional: Check inserted data
SELECT TOP 100 * FROM Transactions;
GO
