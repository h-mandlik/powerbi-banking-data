USE Power_BI;
GO

-- Create a combined dataset table by joining Transactions, Accounts, and Customers
SELECT
    t.TransactionID,
    t.AccountID AS Transaction_AccountID,
    t.TransactionDate,
    t.Type AS TransactionType,
    t.Amount,
    t.Description,
    t.Currency,

    a.AccountID AS Account_AccountID,
    a.CustomerID AS Account_CustomerID,
    a.Type AS AccountType,
    a.OpenDate,
    a.Balance,

    c.CustomerID,
    c.Name,
    c.Gender,
    c.DateOfBirth,
    c.Address,
    c.Email,
    c.Phone
INTO CombinedBankingDataset
FROM
    Transactions t
    LEFT JOIN Accounts a ON t.AccountID = a.AccountID
    LEFT JOIN Customers c ON a.CustomerID = c.CustomerID;
GO

-- Preview the combined dataset
SELECT TOP 100 * FROM CombinedBankingDataset;
GO
