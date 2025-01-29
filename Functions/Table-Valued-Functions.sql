USE UserDB;

-- ***********************************************
-- ** 1️ Inline Table-Valued Functions (ITVF) **
-- ***********************************************
-- No BEGIN...END is required!

-- Find Account Holder Name Based on Account ID
CREATE FUNCTION udfFindBalanceOfAccountHolder(@AccountId INT)
RETURNS TABLE
AS
RETURN (
    SELECT AccountHolderName FROM Accounts WHERE AccountID = @AccountId
);

SELECT * FROM udfFindBalanceOfAccountHolder(2);

--  Get All Active Employees
CREATE FUNCTION udfGetActiveEmployees()
RETURNS TABLE
AS
RETURN (
    SELECT EmployeeID, Name, Department FROM Employees WHERE Status = 'Active'
);

SELECT * FROM udfGetActiveEmployees();

--  Get Orders for a Specific Customer
CREATE FUNCTION udfGetOrdersByCustomer(@CustomerName Varchar(25))
RETURNS TABLE
AS
RETURN (
    SELECT OrderID, TotalAmount FROM Orders WHERE CustomerName = @CustomerName
);

SELECT * FROM udfGetOrdersByCustomer('Alice Smith');

--  Get All Products
CREATE FUNCTION udfGetProducts()
RETURNS TABLE
AS
RETURN (
    SELECT ProductID, ProductName, Stock FROM Products
);

SELECT * FROM udfGetProducts();

--  Get Employees with a Salary Greater Than a Certain Amount
CREATE FUNCTION udfGetHighSalaryEmployees(@MinSalary DECIMAL(10,2))
RETURNS TABLE
AS
RETURN (
    SELECT EmployeeID, Name, Salary FROM Employees WHERE Salary > @MinSalary
);

SELECT * FROM udfGetHighSalaryEmployees(50000);

-- ***********************************************
-- ** 2️ Multi-Statement Table-Valued Functions (MSTVF) **
-- ***********************************************
-- BEGIN...END is Mandatory!

--  Get Total Salary Paid in Each Department
CREATE FUNCTION udfTotalSalaryByDepartment()
RETURNS @SalaryTable TABLE (Department VARCHAR(50), TotalSalary DECIMAL(10,2)) --Table Variable Creation
AS
BEGIN
    INSERT INTO @SalaryTable
    SELECT Department, SUM(Salary) AS TotalSalary FROM Employees GROUP BY Department;
    
    RETURN;
END;

SELECT * FROM udfTotalSalaryByDepartment();

--  Get Order Details for a Given Order ID
CREATE FUNCTION udfGetOrderDetails(@OrderID INT)
RETURNS @OrderTable TABLE (ProductName VARCHAR(100), Quantity INT, Price DECIMAL(10,2))
AS
BEGIN
    INSERT INTO @OrderTable
    SELECT P.ProductName, OI.Quantity, OI.Price
    FROM OrderDetails OI
    JOIN Products P 
	ON OI.ProductID = P.ProductID
    WHERE OI.OrderID = @OrderID;
    
    RETURN;
END;

SELECT * FROM udfGetOrderDetails(3);

--  Get List of Employees Who Joined in a Specific Year
CREATE FUNCTION udfGetEmployeesByJoiningYear(@JoinYear INT)
RETURNS @EmployeeTable TABLE (EmployeeID INT, Name VARCHAR(100), JoinDate DATE)
AS
BEGIN
    INSERT INTO @EmployeeTable
    SELECT EmployeeID, Name, JoinDate FROM Employees WHERE YEAR(JoinDate) = @JoinYear;
    
    RETURN;
END;

SELECT * FROM udfGetEmployeesByJoiningYear(2022);