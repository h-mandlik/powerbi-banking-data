USE Power_BI;
GO

-- Standardize OpenDate in Accounts
UPDATE Accounts
SET OpenDate = 
    CASE
        WHEN TRY_CONVERT(date, OpenDate, 101) IS NOT NULL 
            THEN FORMAT(TRY_CONVERT(date, OpenDate, 101), 'MM/dd/yyyy')
        WHEN TRY_CONVERT(date, OpenDate, 23) IS NOT NULL    
            THEN FORMAT(TRY_CONVERT(date, OpenDate, 23), 'MM/dd/yyyy')
        WHEN TRY_CONVERT(date, OpenDate, 111) IS NOT NULL   
            THEN FORMAT(TRY_CONVERT(date, OpenDate, 111), 'MM/dd/yyyy')
        WHEN TRY_CONVERT(date, OpenDate, 105) IS NOT NULL  
            THEN FORMAT(TRY_CONVERT(date, OpenDate, 105), 'MM/dd/yyyy')
        WHEN TRY_CONVERT(date, OpenDate, 103) IS NOT NULL
            THEN FORMAT(TRY_CONVERT(date, OpenDate, 103), 'MM/dd/yyyy') 
        ELSE OpenDate
    END;
GO

-- Standardize DateOfBirth in Customers
UPDATE Customers
SET DateOfBirth = 
    CASE
        WHEN TRY_CONVERT(date, DateOfBirth, 101) IS NOT NULL 
            THEN FORMAT(TRY_CONVERT(date, DateOfBirth, 101), 'MM/dd/yyyy')
        WHEN TRY_CONVERT(date, DateOfBirth, 23) IS NOT NULL    
            THEN FORMAT(TRY_CONVERT(date, DateOfBirth, 23), 'MM/dd/yyyy')
        WHEN TRY_CONVERT(date, DateOfBirth, 111) IS NOT NULL   
            THEN FORMAT(TRY_CONVERT(date, DateOfBirth, 111), 'MM/dd/yyyy')
        WHEN TRY_CONVERT(date, DateOfBirth, 105) IS NOT NULL  
            THEN FORMAT(TRY_CONVERT(date, DateOfBirth, 105), 'MM/dd/yyyy')
        WHEN TRY_CONVERT(date, DateOfBirth, 103) IS NOT NULL
            THEN FORMAT(TRY_CONVERT(date, DateOfBirth, 103), 'MM/dd/yyyy')
        ELSE DateOfBirth
    END;
GO

-- Standardize TransactionDate in Transactions
UPDATE Transactions
SET TransactionDate = 
    CASE
        WHEN TRY_CONVERT(date, TransactionDate, 101) IS NOT NULL 
            THEN FORMAT(TRY_CONVERT(date, TransactionDate, 101), 'MM/dd/yyyy')
        WHEN TRY_CONVERT(date, TransactionDate, 23) IS NOT NULL    
            THEN FORMAT(TRY_CONVERT(date, TransactionDate, 23), 'MM/dd/yyyy')
        WHEN TRY_CONVERT(date, TransactionDate, 111) IS NOT NULL   
            THEN FORMAT(TRY_CONVERT(date, TransactionDate, 111), 'MM/dd/yyyy')
        WHEN TRY_CONVERT(date, TransactionDate, 105) IS NOT NULL  
            THEN FORMAT(TRY_CONVERT(date, TransactionDate, 105), 'MM/dd/yyyy')
        WHEN TRY_CONVERT(date, TransactionDate, 103) IS NOT NULL
            THEN FORMAT(TRY_CONVERT(date, TransactionDate, 103), 'MM/dd/yyyy')
        ELSE TransactionDate
    END;
GO
