-- Create the Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName NVARCHAR(50),
    OrderDate DATETIME,
    DeliveryDate DATETIME
);

-- Insert data into Orders table
INSERT INTO Orders (OrderID, CustomerName, OrderDate, DeliveryDate) VALUES
(1, 'Alice', '2025-01-01 10:15:00', '2025-01-05 15:00:00'),
(2, 'Bob', '2025-01-02 11:30:00', '2025-01-06 16:30:00'),
(3, 'Charlie', '2025-01-03 12:45:00', '2025-01-07 14:00:00'),
(4, 'Diana', '2025-01-04 09:00:00', '2025-01-08 18:15:00'),
(5, 'Eve', '2025-01-05 14:30:00', '2025-01-09 12:00:00');

select * from Orders;

-- 1. Returning Current Date and Time
SELECT 
    CURRENT_TIMESTAMP AS CurrentDateTime,
    GETDATE() AS SystemDateTime,
    GETUTCDATE() AS UTCDateTime,
    SYSDATETIME() AS HighPrecisionSystemDateTime,
    SYSUTCDATETIME() AS HighPrecisionUTCDateTime,
    SYSDATETIMEOFFSET() AS SystemDateTimeWithOffset;

-- 2. Extracting Date and Time Parts
SELECT 
    OrderID,
    CustomerName,
    OrderDate,
    DATENAME(DAY, OrderDate) AS DayName,
    DATEPART(DAY, OrderDate) AS DayNumber,
    MONTH(OrderDate) AS MonthNumber,
    YEAR(OrderDate) AS YearNumber
FROM Orders;

-- 3. Calculating Date Differences
SELECT 
    OrderID,
    DATEDIFF(DAY, OrderDate, DeliveryDate) AS DaysToDeliver,
    DATEDIFF(HOUR, OrderDate, DeliveryDate) AS HoursToDeliver
FROM Orders;

-- 4. Modifying Dates
SELECT 
    OrderID,
    OrderDate,
    DATEADD(DAY, 7, OrderDate) AS OneWeekLater,
    DATEADD(MONTH, 1, OrderDate) AS OneMonthLater,
    EOMONTH(OrderDate) AS EndOfMonth,
    SWITCHOFFSET(CAST(OrderDate AS DATETIMEOFFSET), '+05:30') AS AdjustedTimeZone,
    TODATETIMEOFFSET(OrderDate, '+05:30') AS ConvertedToOffsetDateTime
FROM Orders;

-- 5. Constructing Dates and Times
SELECT 
    OrderID,
    CustomerName,
    OrderDate,
    DATEFROMPARTS(YEAR(OrderDate), MONTH(OrderDate), 1) AS FirstDayOfMonth,
    DATETIME2FROMPARTS(YEAR(OrderDate), MONTH(OrderDate), DAY(OrderDate), 0, 0, 0, 0, 0) AS MidnightTime
FROM Orders;

-- 6. Validating Dates
SELECT 
    OrderID,
    OrderDate,
    ISDATE(OrderDate) AS IsOrderDateValid,
    ISDATE('2025-13-01') AS IsInvalidDateValid -- Example of an invalid date
FROM Orders;

