-- Switch to the database
USE DemoDB;

-- Create the Employees table
CREATE TABLE Employees (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(25) NOT NULL,
    Email VARCHAR(35) UNIQUE,
    Phone BIGINT UNIQUE
);

-- Insert sample data into the Employees table
INSERT INTO Employees (Name, Email, Phone) 
VALUES 
    ('John Doe', 'john.doe@example.com', 9876543210),
    ('Jane Smith', 'jane.smith@example.com', 8765432109),
    ('Alice Johnson', 'alice.johnson@example.com', 7654321098),
    ('Bob Brown', 'bob.brown@example.com', 6543210987),
    ('Emily Davis', 'emily.davis@example.com', 5432109876),
    ('Michael Wilson', 'michael.wilson@example.com', 4321098765),
    ('Sarah Taylor', 'sarah.taylor@example.com', 3210987654);

-- Stored Procedure: Fetch all data from Employees
CREATE PROCEDURE spFetchAll
AS
BEGIN
    SELECT * FROM Employees;
END;

-- Execute the spFetchAll stored procedure
EXECUTE spFetchAll;

-- Stored Procedure: Fetch data based on ID
CREATE PROCEDURE spFetchById (@Id INT)
AS
BEGIN
    SELECT * FROM Employees WHERE ID = @Id;
END;

-- Execute the spFetchById stored procedure
EXEC spFetchById @Id = 5;

-- Stored Procedure: Update employee data based on ID
CREATE PROCEDURE spUpdateEmployee (
    @Id INT, 
    @Ename VARCHAR(25), 
    @Eemail VARCHAR(35)
)
AS
BEGIN
    UPDATE Employees 
    SET Name = @Ename, Email = @Eemail 
    WHERE ID = @Id;
END;

-- Execute the spUpdateEmployee stored procedure
EXEC spUpdateEmployee @Id = 5, @Ename = 'Travis Head', @Eemail = 'travis.head@example.com';

-- Stored Procedure: Insert data into Employees
CREATE PROCEDURE spInsertIntoEmployees (
    @Ename VARCHAR(25), 
    @Eemail VARCHAR(35), 
    @Ephone BIGINT
)
AS
BEGIN
    INSERT INTO Employees (Name, Email, Phone) 
    VALUES (@Ename, @Eemail, @Ephone);
END;

-- Execute the spInsertIntoEmployees stored procedure
EXEC spInsertIntoEmployees @Ename = 'Lionel Messi', @Eemail = 'lionel.messi@example.com', @Ephone = 8564245756;

-- Stored Procedure: Delete employee data using ID
CREATE PROCEDURE spDeleteEmployeeById (@Id INT)
AS
BEGIN
    DELETE FROM Employees 
    WHERE ID = @Id;
END;

-- Execute the spDeleteEmployeeById stored procedure
EXEC spDeleteEmployeeById @Id = 8;
