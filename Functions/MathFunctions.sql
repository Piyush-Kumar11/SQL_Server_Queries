-- Create SalesData Table
CREATE TABLE SalesData (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    SaleMonth NVARCHAR(20),
    UnitsSold INT,
    UnitPrice DECIMAL(10, 2),
    Discount DECIMAL(5, 2),
    Revenue DECIMAL(15, 2)
);

-- Insert Data into SalesData Table
INSERT INTO SalesData (SaleID, ProductID, SaleMonth, UnitsSold, UnitPrice, Discount, Revenue)
VALUES 
(1, 1, 'January', 150, 499.99, 10.00, 67498.50), -- Revenue: (UnitsSold * UnitPrice * (1 - Discount / 100))
(2, 2, 'February', 120, 299.99, 5.00, 34198.80),
(3, 3, 'March', 200, 199.99, 15.00, 33998.20),
(4, 1, 'April', 180, 499.99, 20.00, 71998.20),
(5, 2, 'May', 50, 299.99, 0.00, 14999.50);

-- 1. Calculate Total Revenue Before and After Discount
SELECT 
    SaleID,
    ProductID,
    SaleMonth,
    UnitsSold,
    UnitPrice,
    (UnitsSold * UnitPrice) AS RevenueBeforeDiscount,
    (UnitsSold * UnitPrice) * (1 - Discount / 100) AS RevenueAfterDiscount
FROM SalesData;

-- 2. Calculate Average Revenue and Standard Deviation
SELECT 
    AVG(Revenue) AS AverageRevenue,
    STDEV(Revenue) AS RevenueStandardDeviation
FROM SalesData;

-- 3. Absolute Difference Between Units Sold and Average Units Sold
SELECT 
    SaleID,
    UnitsSold,
    ABS(UnitsSold - (SELECT AVG(UnitsSold) FROM SalesData)) AS AbsDifferenceFromAvg
FROM SalesData;

-- 4. Ceiling and Floor of Revenue
SELECT 
    SaleID,
    Revenue,
    CEILING(Revenue) AS RevenueCeiling,
    FLOOR(Revenue) AS RevenueFloor
FROM SalesData;

-- 5. Logarithmic Calculations on Revenue
SELECT 
    SaleID,
    Revenue,
    LOG(Revenue) AS NaturalLog,
    LOG10(Revenue) AS LogBase10
FROM SalesData;

-- 6. Generate Random Discounts for Each Sale
SELECT 
    SaleID,
    Discount,
    RAND(SaleID) * 20 AS RandomDiscount
FROM SalesData;

-- 7. Calculate Square and Square Root of Units Sold
SELECT 
    SaleID,
    UnitsSold,
    POWER(UnitsSold, 2) AS SquareOfUnitsSold,
    SQRT(UnitsSold) AS SquareRootOfUnitsSold
FROM SalesData;

-- 8. Revenue as a Percentage of Total Revenue
SELECT 
    SaleID,
    Revenue,
    (Revenue / (SELECT SUM(Revenue) FROM SalesData)) * 100 AS RevenuePercentage
FROM SalesData;

-- 9. Modulo Operation to Group Sales by Units Sold
SELECT 
    SaleID,
    UnitsSold,
    UnitsSold % 50 AS RemainderWhenDividedBy50
FROM SalesData;

-- 10. Revenue Trend Calculation
SELECT 
    SaleID,
    SaleMonth,
    Revenue,
    LAG(Revenue) OVER (ORDER BY SaleID) AS PreviousMonthRevenue,
    (Revenue - LAG(Revenue) OVER (ORDER BY SaleID)) AS RevenueDifference
FROM SalesData;
