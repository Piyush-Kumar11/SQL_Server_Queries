USE DemoDB;

-- =======================================
-- Problem 1: Divide Two Numbers with TRY-CATCH
-- =======================================
CREATE PROCEDURE spDivideNumbers(@n1 INT, @n2 INT)
AS
BEGIN
	BEGIN TRY
		DECLARE @result INT;
		Select @result = @n1 / @n2;
		Select @result AS 'Result';
	END TRY
	BEGIN CATCH
		SELECT 'Divide By Zero OCCURRED' AS 'EXCEPTION',
				ERROR_LINE() AS 'ERROR_Line',
				ERROR_MESSAGE() AS 'ERROR_MSG',
				ERROR_NUMBER() AS 'ERROR_NUM',
				ERROR_PROCEDURE() AS 'ERROR_PROCEDURE',
				ERROR_SEVERITY() AS 'ERROR_SEVERITY',
				ERROR_STATE() AS 'ERROR_STATE';
	END CATCH
END;

EXEC spDivideNumbers @n1 = 2, @n2 = 0;

-- =======================================
-- Problem 2: Nested TRY-CATCH Example
-- =======================================
CREATE PROCEDURE spNestedTryCatch(@n1 INT, @n2 INT, @n3 INT)
AS
BEGIN
	BEGIN TRY
		BEGIN TRY
			-- Nested TRY Block: Division
			DECLARE @result INT;
			Select @result = @n1 / @n2;
			Select @result AS 'Result';
		END TRY
		BEGIN CATCH
			-- Nested CATCH Block: Handles Division Error
			SELECT 'Inner Try-Catch: Error in Division' AS 'ERROR_MSG',
				ERROR_MESSAGE() AS 'ERROR_MESSAGE',
				ERROR_NUMBER() AS 'ERROR_NUMBER';
		END CATCH
	END TRY
	BEGIN CATCH
		-- Outer CATCH Block: Handles Outer Error
		SELECT 'Outer Try-Catch: Error Detected' AS 'ERROR_MSG',
				ERROR_MESSAGE() AS 'ERROR_MESSAGE',
				ERROR_NUMBER() AS 'ERROR_NUMBER';
	END CATCH
END;

EXEC spNestedTryCatch @n1 = 2, @n2 = 0, @n3 = 5;

-- =======================================
-- Problem 3: THROW Example
-- =======================================
CREATE PROCEDURE spThrowExample(@n1 INT, @n2 INT)
AS
BEGIN
	BEGIN TRY
		IF @n2 = 0
			THROW 50000, 'Division by zero is not allowed.', 1;
		ELSE
			DECLARE @result INT;
			Select @result = @n1 / @n2;
			Select @result AS 'Result';
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS 'Error Message';
	END CATCH
END;

EXEC spThrowExample @n1 = 10, @n2 = 0;

-- =======================================
-- Problem 4: Handling Primary Key Constraint Violation
-- =======================================
CREATE PROCEDURE spInsertEmployee(@Name VARCHAR(25), @Email VARCHAR(35), @Phone BIGINT)
AS
BEGIN
	BEGIN TRY
		INSERT INTO Employees (Name, Email, Phone)
		VALUES (@Name, @Email, @Phone);
		PRINT 'Employee Inserted Successfully';
	END TRY
	BEGIN CATCH
		SELECT 'Error Inserting Employee' AS 'ERROR_MSG',
				ERROR_MESSAGE() AS 'ERROR_MESSAGE';
	END CATCH
END;

EXEC spInsertEmployee @Name = 'John Doe', @Email = 'john.doe@example.com', @Phone = 1234567890;
-- Try inserting duplicate phone to check primary key violation

-- =======================================
-- Problem 5: Handle Transaction Error
-- =======================================
CREATE PROCEDURE spHandleTransactionError
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION;
		-- Intentional Error: Inserting duplicate email (for unique constraint violation)
		INSERT INTO Employees (Name, Email, Phone) 
		VALUES ('Alice', 'alice@example.com', 1234567890);

		INSERT INTO Employees (Name, Email, Phone) 
		VALUES ('Bob', 'alice@example.com', 9876543210); -- Duplicate Email

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		SELECT 'Transaction Rolled Back' AS 'Status',
				ERROR_MESSAGE() AS 'Error Message';
	END CATCH
END;

EXEC spHandleTransactionError;

-- =======================================
-- Problem 6: Rethrowing Custom Error
-- =======================================
CREATE PROCEDURE spRethrowError(@n1 INT, @n2 INT)
AS
BEGIN
	BEGIN TRY
		IF @n2 = 0
			THROW 50001, 'Cannot divide by zero.', 1;
		ELSE
			DECLARE @result INT;
			Select @result = @n1 / @n2;
			Select @result AS 'Result';
	END TRY
	BEGIN CATCH
		THROW; -- Rethrow the error
	END CATCH
END;

EXEC spRethrowError @n1 = 10, @n2 = 0;