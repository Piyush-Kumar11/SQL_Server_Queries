create database FunctionsDB

use FunctionsDB

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY IDENTITY(1, 1),
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    SaleAmount DECIMAL(10, 2),
    SaleDate DATE
);

INSERT INTO Sales (EmployeeName, Department, SaleAmount, SaleDate)
VALUES 
('Alice', 'Electronics', 1500.50, '2025-01-20'),
('Bob', 'Clothing', 800.00, '2025-01-21'),
('Alice', 'Electronics', 2000.00, '2025-01-22'),
('Charlie', 'Clothing', 1200.00, '2025-01-22'),
('Bob', 'Clothing', 700.00, '2025-01-23'),
('Alice', 'Electronics', 1800.00, '2025-01-24'),
('Charlie', 'Clothing', 1500.00, '2025-01-25');

INSERT INTO Sales (EmployeeName, Department, SaleAmount, SaleDate)
VALUES 
('Eve', 'Clothing', 2000.00, '2025-01-26'),  -- Ties with highest SaleAmount
('Frank', 'Electronics', 1500.50, '2025-01-27'),  -- Ties with existing SaleAmount
('Grace', 'Clothing', 1200.00, '2025-01-28'),  -- Ties with existing SaleAmount
('Hannah', 'Electronics', 900.00, '2025-01-29'), -- New SaleAmount
('Ian', 'Clothing', 700.00, '2025-01-30'),       -- Ties with lowest SaleAmount
('Jack', 'Electronics', 1800.00, '2025-01-31');  -- Ties with an existing SaleAmount


Select * from Sales;

-- Query with multiple window functions
SELECT 
    SaleID, 
    EmployeeName, 
    Department, 
    SaleAmount, 
    SaleDate,

    -- ROW_NUMBER() assigns unique row numbers based on SaleAmount in descending order
    ROW_NUMBER() OVER (ORDER BY SaleAmount DESC) AS RowNumber,

    -- RANK() assigns ranks based on SaleAmount, with ties getting the same rank
    RANK() OVER (ORDER BY SaleAmount DESC) AS Rank,

    -- DENSE_RANK() assigns consecutive ranks without gaps for ties
    DENSE_RANK() OVER (ORDER BY SaleAmount DESC) AS DenseRank,

    -- NTILE(3) divides rows into 3 equal groups (quartiles)
    NTILE(3) OVER (ORDER BY SaleAmount DESC) AS Quartile,

    -- Cumulative sum of SaleAmount
    SUM(SaleAmount) OVER (ORDER BY SaleAmount DESC) AS RunningTotal,

    -- Average SaleAmount calculated across all rows
    AVG(SaleAmount) OVER () AS AvgSaleAmount,

    -- Total number of rows (employees) in the table
    COUNT(*) OVER () AS TotalRows,

    -- Maximum SaleAmount in the table
    MAX(SaleAmount) OVER () AS MaxSaleAmount,

    -- Minimum SaleAmount in the table
    MIN(SaleAmount) OVER () AS MinSaleAmount

FROM Sales;