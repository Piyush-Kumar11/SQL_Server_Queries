Use UserDB;

-- Table Creations for the given problems:
-- Create Accounts table
CREATE TABLE Accounts (
    AccountID INT IDENTITY(1,1) PRIMARY KEY,
    AccountHolderName VARCHAR(50) NOT NULL,
    Balance DECIMAL(10, 2) NOT NULL CHECK (Balance >= 0)
);

-- Insert sample data
INSERT INTO Accounts (AccountHolderName, Balance)
VALUES 
('John Doe', 1000.00),
('Jane Doe', 500.00),
('Alice Smith', 2500.00),
('Bob Johnson', 0.00);

-- Create Products table
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    Stock INT NOT NULL CHECK (Stock >= 0)
);

-- Insert sample data
INSERT INTO Products (ProductName, Stock)
VALUES 
('Laptop', 50),
('Smartphone', 100),
('Headphones', 30),
('Keyboard', 75);

-- Create Orders table
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerName NVARCHAR(100) NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL CHECK (TotalAmount >= 0)
);

-- Create DiscountCodes table
CREATE TABLE DiscountCodes (
    Code NVARCHAR(50) PRIMARY KEY,
    DiscountAmount DECIMAL(10, 2) NOT NULL CHECK (DiscountAmount >= 0),
    ExpiryDate DATE NOT NULL
);

-- Insert sample data into Orders
INSERT INTO Orders (CustomerName, TotalAmount)
VALUES 
('John Doe', 1000.00),
('Jane Doe', 1500.00),
('Alice Smith', 2000.00);

-- Insert sample data into DiscountCodes
INSERT INTO DiscountCodes (Code, DiscountAmount, ExpiryDate)
VALUES 
('DISCOUNT50', 50.00, '2025-12-31'),
('DISCOUNT100', 100.00, '2025-06-30'),
('EXPIRED10', 10.00, '2024-12-31');

-- Create Students table
CREATE TABLE Students (
    StudentID INT IDENTITY(1,1) PRIMARY KEY,
    StudentName NVARCHAR(100) NOT NULL
);

-- Create Subjects table
CREATE TABLE Subjects (
    SubjectID INT IDENTITY(1,1) PRIMARY KEY,
    SubjectName NVARCHAR(100) NOT NULL
);

-- Create Grades table
CREATE TABLE Grades (
    StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
    SubjectID INT FOREIGN KEY REFERENCES Subjects(SubjectID),
    Grade DECIMAL(5, 2) CHECK (Grade BETWEEN 0 AND 100),
    PRIMARY KEY (StudentID, SubjectID)
);

-- Insert sample data into Students
INSERT INTO Students (StudentName)
VALUES 
('John Doe'),
('Jane Doe'),
('Alice Smith');

-- Insert sample data into Subjects
INSERT INTO Subjects (SubjectName)
VALUES 
('Mathematics'),
('Science'),
('History');

-- Insert sample data into Grades
INSERT INTO Grades (StudentID, SubjectID, Grade)
VALUES 
(1, 1, 85.50),
(1, 2, 90.00),
(2, 1, 78.00),
(3, 3, 88.00);


/*
1. Banking: Withdrawal with Balance Check (No Logging)
Problem:
- Implement a stored procedure to handle bank account withdrawals. Ensure:
- The withdrawal amount does not exceed the account balance.
- Raise errors for insufficient funds or non-existent accounts.
*/
CREATE Procedure spWithdrawAmount(@AccountID int, @Amount Decimal(10,2))
AS
BEGIN
	BEGIN TRY
		IF NOT EXISTS (SELECT 1 FROM Accounts WHERE AccountID = @AccountID)
			BEGIN
				THROW 50004, 'Account Not Found', 1;
			END

		DECLARE @Balance Decimal(10,2);
		SELECT @Balance = Balance From Accounts Where AccountID=@AccountID;

		IF @Balance < @Amount
			BEGIN
				THROW 50005, 'Insufficient Fund', 1;
			END

		UPDATE Accounts SET Balance = Balance - @Amount WHERE AccountID = @AccountID;
		Print 'Withrawal Success. Remaining Balance: '+Cast(@Balance - @Amount AS NVARCHAR(50));
	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(400), @ErrorSeverity Int, @ErrorState int;
		Select @ErrorMessage = ERROR_MESSAGE(),
				@ErrorSeverity = ERROR_SEVERITY(),
				@ErrorState = ERROR_STATE();
		 THROW 50001, @ErrorMessage, 1;
	END CATCH
END;

EXEC spWithdrawAmount @AccountID = 4, @Amount = 500;

Select * from Accounts;

/*
2. Inventory Management: Stock Update
Problem:
- Implement a stored procedure to update the stock for a product:
- Raise an error if the product doesn’t exist.
- Raise an error if the quantity to remove exceeds available stock.
*/

CREATE PROCEDURE spUpdateStock(@ProductID INT, @Quantity int)
AS
BEGIN
	BEGIN TRY
		IF NOT EXISTS (SELECT 1 FROM Products Where ProductID = @ProductID)
		BEGIN
			THROW 50006,'Product Not Found',1;
		END

		DECLARE @CurrentStock Int;
		Select @CurrentStock = Stock From Products Where ProductID = @ProductID;

		IF @CurrentStock < @Quantity
		BEGIN
			THROW 50006,'Insufficient Stock available',1;
		END

		UPDATE Products SET Stock = Stock - @Quantity Where ProductID = @ProductID;
		Print 'Stock Updated!, Remaining: '+CAST(@CurrentStock-@Quantity AS NVARCHAR(50));
	END TRY
	BEGIN CATCH
		SELECT
            ERROR_MESSAGE() AS 'ErrorMessage',
            ERROR_SEVERITY() AS 'ErrorSeverity',
            ERROR_STATE() AS 'ErrorState';
	END CATCH
END;

EXEC spUpdateStock @ProductID = 3, @Quantity = 30;

Select * from Products;

/*
3. E-commerce: Apply Discount Code
Problem:
- Create a stored procedure to apply a discount code to an order:
- Ensure the discount code is valid and not expired.
- Check if the discount amount is less than or equal to the total order amount.
*/
CREATE PROCEDURE spApplyDiscount(@OrderID INT, @DiscountCode NVARCHAR(50))
AS
BEGIN
	BEGIN TRY
		IF NOT EXISTS (SELECT 1 FROM Orders WHERE OrderID = @OrderID)
		BEGIN
			THROW 50008,'ORDER NOT FOUND!',1;
		END

		IF NOT EXISTS (SELECT 1 FROM DiscountCodes WHERE Code = @DiscountCode AND ExpiryDate >= GETDATE())
		BEGIN 
			THROW 50009, 'INVALID/EXPIRED Coupon Code',1;
		END

		DECLARE @OrderTotal Decimal(10,2), @DiscountValue Decimal(10,2);
		Select @OrderTotal = TotalAmount From Orders Where OrderID = @OrderID;
		Select @DiscountValue = DiscountAmount From DiscountCodes Where Code = @DiscountCode;

		IF @DiscountValue>@OrderTotal
		BEGIN
			THROW 50010, 'Discount Value exceeds order total',1;
		END

		UPDATE Orders SET TotalAmount = TotalAmount-@DiscountValue WHERE OrderID = @OrderID;
		PRINT 'Discount Applied!!, Final Amount: '+CAST(@OrderTotal-@DiscountValue AS NVARCHAR(50));
	END TRY
	BEGIN CATCH
		SELECT
            ERROR_MESSAGE() AS 'ErrorMessage',
            ERROR_SEVERITY() AS 'ErrorSeverity',
            ERROR_STATE() AS 'ErrorState';
	END CATCH
END;

Exec spApplyDiscount @OrderID = 2, @DiscountCode = 'DISCOUNT50';

Select * from Orders;
Select * from DiscountCodes;


/*
4. Student Management: Update Grades
Problem:
- Create a stored procedure to update a student’s grade for a specific subject:
- Ensure the student and subject exist.
- Validate that the grade is within the accepted range (e.g., 0–100).
*/

CREATE PROCEDURE spUpdateStudentGrade(@StudentID INT,@SubjectID INT,@Grade DECIMAL(5, 2))
AS
BEGIN
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Students WHERE StudentID = @StudentID)
			BEGIN
				THROW 50011, 'Student not found.', 1;
			END

        IF NOT EXISTS (SELECT 1 FROM Subjects WHERE SubjectID = @SubjectID)
			BEGIN
				THROW 50012, 'Subject not found.', 1;
			END

        IF @Grade < 0 OR @Grade > 100
			BEGIN
				THROW 50013, 'Invalid grade. Grade must be between 0 and 100.', 1;
			END

        UPDATE Grades SET Grade = @Grade WHERE StudentID = @StudentID AND SubjectID = @SubjectID;

        PRINT 'Grade updated!!!';
    END TRY
    BEGIN CATCH
        SELECT
            ERROR_MESSAGE() AS 'ErrorMessage',
            ERROR_SEVERITY() AS 'ErrorSeverity',
            ERROR_STATE() AS 'ErrorState';
    END CATCH
END;

EXEC spUpdateStudentGrade @StudentID = 5,@SubjectID= 1,@Grade =80 ;

Select * from Students;
Select * from Subjects;
Select * from Grades;
