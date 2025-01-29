USE UserDB;

-- 1️ Finding Sum of Two Numbers
CREATE FUNCTION udfSumOfNumber(@n1 INT, @n2 INT)
RETURNS INT
AS
BEGIN
    DECLARE @Result INT;
    SET @Result = @n1 + @n2;
    RETURN @Result;
END;

SELECT dbo.udfSumOfNumber(2, 5) AS SumOfNum;

-- 2️ Division of Numbers (Handles Division by Zero)
CREATE FUNCTION udfFindDivision(@n1 DECIMAL(5,2), @n2 DECIMAL(5,2))
RETURNS DECIMAL(5,2)
AS
BEGIN
    RETURN CASE  
        WHEN @n2 = 0 THEN NULL  -- Avoid division by zero  
        ELSE @n1 / @n2  
    END;  
END;

SELECT dbo.udfFindDivision(25, 5.5) AS 'Result';

-- 3️ Find Day Difference Between Two Dates
CREATE FUNCTION udfDifferenceInDates(@date1 DATE, @date2 DATE)
RETURNS INT
AS
BEGIN
    DECLARE @Diff INT;
    SET @Diff = DATEDIFF(DAY, @date1, @date2);
    RETURN @Diff;
END;

SELECT dbo.udfDifferenceInDates('2000-10-10', '2025-01-29') AS 'NoOfDays';

-- 4️ Find Maximum Amount from Orders Table
CREATE FUNCTION udfFindMaxAmount()
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Max DECIMAL(10,2);
    SELECT @Max = MAX(TotalAmount) FROM Orders;
    RETURN @Max;
END;

SELECT dbo.udfFindMaxAmount() AS 'Maximum Amount';

-- 5️ Find Square of a Number
CREATE FUNCTION udfSquare(@num INT)
RETURNS INT
AS
BEGIN
    DECLARE @result INT;
    SET @result = @num * @num;
    RETURN @result;
END;

SELECT dbo.udfSquare(5) AS SquareValue;

-- 6️ Convert Celsius to Fahrenheit
CREATE FUNCTION udfCelsiusToFahrenheit(@celsius DECIMAL(5,2))
RETURNS DECIMAL(5,2)
AS
BEGIN
    DECLARE @fahrenheit DECIMAL(5,2);
    SET @fahrenheit = (@celsius * 9/5) + 32;
    RETURN @fahrenheit;
END;

SELECT dbo.udfCelsiusToFahrenheit(25) AS Fahrenheit;

-- 7️ Calculate Factorial of a Number
CREATE FUNCTION udfFactorial(@num INT)
RETURNS BIGINT
AS
BEGIN
    DECLARE @fact BIGINT = 1;
    DECLARE @i INT = 1;
    
    WHILE @i <= @num
    BEGIN
        SET @fact = @fact * @i;
        SET @i = @i + 1;
    END;
    
    RETURN @fact;
END;

SELECT dbo.udfFactorial(5) AS Factorial;

-- 8️ Get First Name from Full Name
CREATE FUNCTION udfGetFirstName(@fullName VARCHAR(100))
RETURNS VARCHAR(50)
AS
BEGIN
    RETURN LEFT(@fullName, CHARINDEX(' ', @fullName + ' ') - 1);
END;

SELECT dbo.udfGetFirstName('Piyush Kumar') AS FirstName;

-- 9️ Get Last Name from Full Name
CREATE FUNCTION udfGetLastName(@fullName VARCHAR(100))
RETURNS VARCHAR(50)
AS
BEGIN
    RETURN RIGHT(@fullName, CHARINDEX(' ', REVERSE(@fullName) + ' ') - 1);
END;

SELECT dbo.udfGetLastName('Piyush Kumar') AS LastName;

-- 10 Calculate Simple Interest
CREATE FUNCTION udfSimpleInterest(@principal DECIMAL(10,2), @rate DECIMAL(5,2), @time INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @interest DECIMAL(10,2);
    SET @interest = (@principal * @rate * @time) / 100;
    RETURN @interest;
END;

SELECT dbo.udfSimpleInterest(10000, 5, 2) AS Interest;

-- 1️1️ Check if a Number is Even or Odd
CREATE FUNCTION udfIsEven(@num INT)
RETURNS VARCHAR(10)
AS
BEGIN
    RETURN CASE  
        WHEN @num % 2 = 0 THEN 'Even'  
        ELSE 'Odd'  
    END;  
END;

SELECT dbo.udfIsEven(7) AS NumberType;
