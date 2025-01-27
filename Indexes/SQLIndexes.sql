use FunctionsDB;

-- Create Employees Table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Department NVARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE
);

-- Insert sample data into Employees Table
INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary, HireDate)
VALUES
(1, 'John', 'Doe', 'Engineering', 75000.00, '2020-05-12'),
(2, 'Jane', 'Smith', 'HR', 60000.00, '2019-06-15'),
(3, 'Mary', 'Johnson', 'Finance', 80000.00, '2021-01-10'),
(4, 'James', 'Brown', 'Engineering', 70000.00, '2018-11-25'),
(5, 'Emily', 'Davis', 'Marketing', 65000.00, '2022-03-05');

-- 1. Clustered Index (Automatically created on Primary Key)
-- The Primary Key (EmployeeID) automatically creates a clustered index
-- No explicit command needed for clustered index, as it is created automatically with the Primary Key

-- To see the index, you can query system views:
SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('Employees');

-- 2. Non-Clustered Index: Create a Non-Clustered Index on Department
CREATE NONCLUSTERED INDEX idx_department ON Employees(Department);

-- 3. Querying the Non-Clustered Index
SELECT * FROM Employees WHERE Department = 'Engineering';

-- 4. Renaming an Index
EXEC sp_rename 'idx_department', 'idx_employee_department';

-- 5. Dropping an Index
DROP INDEX idx_employee_department ON Employees;

-- 6. Unique Index: Create a Unique Non-Clustered Index on FirstName
CREATE UNIQUE NONCLUSTERED INDEX idx_unique_firstname ON Employees(FirstName);

-- Try inserting a duplicate FirstName (this will fail)
-- INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary, HireDate)
-- VALUES (6, 'John', 'Taylor', 'HR', 50000.00, '2022-05-15'); -- Will fail because 'John' already exists in FirstName

-- 7. Disabling an Index
-- Disabling the Non-Clustered Index
ALTER INDEX idx_employee_department ON Employees DISABLE;

-- 8. Enabling an Index (Rebuilding it)
ALTER INDEX idx_employee_department ON Employees REBUILD;

-- 9. Check indexes again after disabling and enabling
SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('Employees');

-- 10. Query the Employees Table to see results
SELECT * FROM Employees;

-- Clean up the indexes and the table
DROP INDEX IF EXISTS idx_employee_department ON Employees;
DROP TABLE IF EXISTS Employees;
