USE DemoDB;

-- =======================================
-- Problem 1: Check if Employee Exists by ID (IF-ELSE)
-- =======================================
CREATE PROCEDURE spCheckEmployeeExistsById(@EmployeeID INT)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Employees WHERE ID = @EmployeeID)
        PRINT 'Employee Exists';
    ELSE
        PRINT 'Employee Does Not Exist';
END;

EXEC spCheckEmployeeExistsById @EmployeeID = 3;

-- =======================================
-- Problem 2: Fetch Employee Details by ID (IF-ELSE)
-- =======================================
CREATE PROCEDURE spFetchEmployeeDetails(@EmployeeID INT)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Employees WHERE ID = @EmployeeID)
    BEGIN
        SELECT ID, Name, Email, Phone 
        FROM Employees 
        WHERE ID = @EmployeeID;
    END
    ELSE
    BEGIN
        PRINT 'Employee Not Found';
    END
END;

EXEC spFetchEmployeeDetails @EmployeeID = 2;

-- =======================================
-- Problem 3: Update Employee Phone Number (IF-ELSE)
-- =======================================
CREATE PROCEDURE spUpdateEmployeePhone(@EmployeeID INT, @NewPhone BIGINT)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Employees WHERE ID = @EmployeeID)
    BEGIN
        UPDATE Employees 
        SET Phone = @NewPhone 
        WHERE ID = @EmployeeID;
        PRINT 'Phone number updated';
    END
    ELSE
    BEGIN
        PRINT 'Employee Not Found';
    END
END;

EXEC spUpdateEmployeePhone @EmployeeID = 2, @NewPhone = 1234567890;

-- =======================================
-- Problem 4: Delete Employee by ID (IF-ELSE)
-- =======================================
CREATE PROCEDURE spDeleteEmployeeByIdIfElse(@EmployeeID INT)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Employees WHERE ID = @EmployeeID)
    BEGIN
        DELETE FROM Employees WHERE ID = @EmployeeID;
        PRINT 'Employee deleted';
    END
    ELSE
    BEGIN
        PRINT 'Employee Not Found';
    END
END;

EXEC spDeleteEmployeeByIdIfElse @EmployeeID = 7;

-- =======================================
-- Problem 5: Check Phone Number Uniqueness (IF-ELSE)
-- =======================================
CREATE PROCEDURE spCheckPhoneExists(@Phone BIGINT)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Employees WHERE Phone = @Phone)
        PRINT 'Phone number already exists';
    ELSE
        PRINT 'Phone number is unique';
END;

EXEC spCheckPhoneExists @Phone = 1234567890;

-- =======================================
-- Problem 6: List Employees One by One (WHILE Loop)
-- =======================================
CREATE PROCEDURE spListEmployeesByWhile
AS
BEGIN
    DECLARE @EmployeeID INT = 1;
    DECLARE @MaxID INT;

    SELECT @MaxID = MAX(ID) FROM Employees;

    WHILE @EmployeeID <= @MaxID
    BEGIN
        SELECT Name FROM Employees WHERE ID = @EmployeeID;
        SET @EmployeeID = @EmployeeID + 1;
    END;
END;

EXEC spListEmployeesByWhile;

-- =======================================
-- Problem 7: Count Employees Based on Condition (IF-ELSE)
-- =======================================
CREATE PROCEDURE spCountEmployeesWithCondition(@Phone BIGINT)
AS
BEGIN
    DECLARE @Count INT;

    IF EXISTS (SELECT 1 FROM Employees WHERE Phone = @Phone)
    BEGIN
        SELECT @Count = COUNT(*) FROM Employees WHERE Phone = @Phone;
        PRINT 'Employees with this phone number: ' + CAST(@Count AS VARCHAR);
    END
    ELSE
    BEGIN
        PRINT 'No employees with this phone number found';
    END
END;

EXEC spCountEmployeesWithCondition @Phone = 9876543210;

-- =======================================
-- Problem 8: Delete Employees by Condition using WHILE Loop
-- =======================================
CREATE PROCEDURE spDeleteEmployeesWithPhone(@Phone BIGINT)
AS
BEGIN
    DECLARE @EmployeeID INT = 1;
    DECLARE @MaxID INT;

    SELECT @MaxID = MAX(ID) FROM Employees;

    WHILE @EmployeeID <= @MaxID
    BEGIN
        IF EXISTS (SELECT 1 FROM Employees WHERE ID = @EmployeeID AND Phone = @Phone)
        BEGIN
            DELETE FROM Employees WHERE ID = @EmployeeID;
            PRINT 'Deleted Employee ID: ' + CAST(@EmployeeID AS VARCHAR);
        END
        SET @EmployeeID = @EmployeeID + 1;
    END;
END;

EXEC spDeleteEmployeesWithPhone @Phone = 9876543210;

-- =======================================
-- Problem 9: Nested IF-ELSE to Check Employee by ID and Name
-- =======================================
CREATE PROCEDURE spCheckEmployeeByIdAndName(@EmployeeID INT, @EmployeeName VARCHAR(25))
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Employees WHERE ID = @EmployeeID)
    BEGIN
        DECLARE @DBName VARCHAR(25);
        SELECT @DBName = Name FROM Employees WHERE ID = @EmployeeID;

        IF @DBName = @EmployeeName
            PRINT 'Employee ID and Name match';
        ELSE
            PRINT 'Employee Name does not match';
    END
    ELSE
    BEGIN
        PRINT 'Employee Not Found';
    END
END;

EXEC spCheckEmployeeByIdAndName @EmployeeID = 4, @EmployeeName = 'John Doe';

-- =======================================
-- Problem 10: WHILE Loop to Delete Employees One by One by ID
-- =======================================
CREATE PROCEDURE spDeleteEmployeesGreaterThanId(@Id INT)
AS
BEGIN
    DECLARE @EmployeeID INT = @Id;
    DECLARE @MaxID INT;

    SELECT @MaxID = MAX(ID) FROM Employees;

    WHILE @EmployeeID <= @MaxID
    BEGIN
        DELETE FROM Employees WHERE ID = @EmployeeID;
        PRINT 'Deleted Employee ID: ' + CAST(@EmployeeID AS VARCHAR);
        SET @EmployeeID = @EmployeeID + 1;
    END;
END;

EXEC spDeleteEmployeesGreaterThanId @Id = 5;
