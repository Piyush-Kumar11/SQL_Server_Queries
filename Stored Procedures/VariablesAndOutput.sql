USE DemoDB;

-- ========================================
-- Section 1: Using DECLARE in Stored Procedures
-- ========================================

-- 1. Stored Procedure: Count Total Employees
CREATE PROCEDURE spCountEmployees
AS
BEGIN
    DECLARE @Count INT;
    
    SELECT @Count = COUNT(ID) FROM Employees;
    
    SELECT @Count AS 'Total_Employees';
END;

-- Execute the procedure to count employees
EXEC spCountEmployees;

-- 2. Stored Procedure: Find Employee Name by ID
CREATE PROCEDURE spFindNameOfEmployee(@Id INT)
AS
BEGIN
    DECLARE @Ename VARCHAR(25);
    
    SELECT @Ename = Name FROM Employees WHERE ID = @Id;
    
    SELECT @Ename AS 'NAME';
END;

-- Execute the procedure to find the name of the employee with ID = 2
EXEC spFindNameOfEmployee @Id = 2;

-- 3. Stored Procedure: Find Employee Email by ID
CREATE PROCEDURE spFindEmailOfEmployee(@Id INT)
AS
BEGIN
    DECLARE @Eemail VARCHAR(35);
    
    SELECT @Eemail = Email FROM Employees WHERE ID = @Id;
    
    SELECT @Eemail AS 'EMAIL';
END;

-- Execute the procedure to find the email of the employee with ID = 2
EXEC spFindEmailOfEmployee @Id = 2;

-- 4. Stored Procedure: Find Employee Phone by ID
CREATE PROCEDURE spFindPhoneOfEmployee(@Id INT)
AS
BEGIN
    DECLARE @Ephone BIGINT;
    
    SELECT @Ephone = Phone FROM Employees WHERE ID = @Id;
    
    SELECT @Ephone AS 'PHONE';
END;

-- Execute the procedure to find the phone number of the employee with ID = 2
EXEC spFindPhoneOfEmployee @Id = 2;

-- 5. Stored Procedure: Find Employee ID by Name
CREATE PROCEDURE spFindIDOfEmployee(@Ename VARCHAR(25))
AS
BEGIN
    DECLARE @Id INT;
    
    SELECT @Id = ID FROM Employees WHERE Name = @Ename;
    
    SELECT @Id AS 'ID';
END;

-- Execute the procedure to find the ID of the employee with name 'Travis Head'
EXEC spFindIDOfEmployee @Ename = 'Travis Head';

-- ========================================
-- Section 2: Using OUTPUT in Stored Procedures
-- ========================================

-- 1. Using OUTPUT Keyword to Return Total Employee Count
CREATE PROCEDURE spCountEmployeesWithOutput(@TotalCount INT OUTPUT)
AS
BEGIN
    SELECT @TotalCount = COUNT(ID) FROM Employees;
END;

DECLARE @CountOutput INT; --Declare a variable to store returned value
EXEC spCountEmployeesWithOutput @TotalCount = @CountOutput OUTPUT;
SELECT @CountOutput AS 'Total_Employees';

-- 2. Using OUTPUT Keyword to Return Employee Name by ID
CREATE PROCEDURE spFindNameWithOutput(@Id INT, @Ename VARCHAR(25) OUTPUT)
AS
BEGIN
    SELECT @Ename = Name FROM Employees WHERE ID = @Id;
END;

DECLARE @NameOutput VARCHAR(25);
EXEC spFindNameWithOutput @Id = 2, @Ename = @NameOutput OUTPUT;
SELECT @NameOutput;

-- 3. Using OUTPUT Keyword to Return Employee Email by ID
CREATE PROCEDURE spFindEmailWithOutput(@Id INT, @Eemail VARCHAR(35) OUTPUT)
AS
BEGIN
    SELECT @Eemail = Email FROM Employees WHERE ID = @Id;
END;

DECLARE @EmailOutput VARCHAR(35);
EXEC spFindEmailWithOutput @Id = 2, @Eemail = @EmailOutput OUTPUT;
SELECT @EmailOutput;

-- 4. Using OUTPUT Keyword to Return Employee Phone by ID
CREATE PROCEDURE spFindPhoneWithOutput(@Id INT, @Ephone BIGINT OUTPUT)
AS
BEGIN
    SELECT @Ephone = Phone FROM Employees WHERE ID = @Id;
END;

DECLARE @PhoneOutput BIGINT;
EXEC spFindPhoneWithOutput @Id = 2, @Ephone = @PhoneOutput OUTPUT;
SELECT @PhoneOutput AS 'Employee Phone: ';

-- 5. Using OUTPUT Keyword to Return Employee ID by Name
CREATE PROCEDURE spFindIDWithOutput(@Ename VARCHAR(25), @Id INT OUTPUT)
AS
BEGIN
    SELECT @Id = ID FROM Employees WHERE Name = @Ename;
END;

DECLARE @IdOutput INT;
EXEC spFindIDWithOutput @Ename = 'Travis Head', @Id = @IdOutput OUTPUT;
SELECT @IdOutput AS 'Employee ID: ';
