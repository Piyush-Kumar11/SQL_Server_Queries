Use FunctionsDB;

-- Create the Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    Quantity INT
);

-- Insert data into Products table
INSERT INTO Products (ProductID, ProductName, Category, Price, Quantity) VALUES
(1, 'Laptop', 'Electronics', 800.00, 10),
(2, 'Smartphone', 'Electronics', 500.00, 25),
(3, 'Tablet', 'Electronics', 300.00, 15),
(4, 'T-Shirt', 'Clothing', 20.00, 50),
(5, 'Jeans', 'Clothing', 40.00, 30),
(6, 'Jacket', 'Clothing', 100.00, 20),
(7, 'Headphones', 'Electronics', 50.00, 40),
(8, 'Shoes', 'Clothing', 80.00, 10),
(9, 'Monitor', 'Electronics', 200.00, 5),
(10, 'Dress', 'Clothing', 60.00, 15);

-- Overall aggregates for the Products table
SELECT 
    COUNT(*) AS TotalProducts,         -- Total number of products
    COUNT(DISTINCT Category) AS TotalCategories, -- Number of unique categories
    SUM(Price) AS TotalPrice,          -- Sum of all product prices
    AVG(Price) AS AveragePrice,        -- Average price of all products
    MAX(Price) AS MaximumPrice,        -- Highest price
    MIN(Price) AS MinimumPrice         -- Lowest price
FROM Products;

-- Aggregates grouped by Category
SELECT 
    Category,
    COUNT(*) AS TotalProductsInCategory, -- Total products in each category
    SUM(Price) AS TotalPriceByCategory,  -- Total price for each category
    AVG(Price) AS AveragePriceByCategory, -- Average price for each category
    MAX(Price) AS MaximumPriceByCategory, -- Maximum price in each category
    MIN(Price) AS MinimumPriceByCategory  -- Minimum price in each category
FROM Products
GROUP BY Category;

-- Aggregates grouped by Price Range
SELECT 
    CASE 
        WHEN Price < 100 THEN 'Low Price (<100)'
        WHEN Price BETWEEN 100 AND 500 THEN 'Medium Price (100-500)'
        ELSE 'High Price (>500)'
    END AS PriceRange,
    COUNT(*) AS TotalProductsInPriceRange, -- Total products in each price range
    SUM(Quantity) AS TotalQuantityInPriceRange, -- Total quantity in each price range
    AVG(Price) AS AveragePriceInRange      -- Average price in each price range
FROM Products
GROUP BY 
    CASE 
        WHEN Price < 100 THEN 'Low Price (<100)'
        WHEN Price BETWEEN 100 AND 500 THEN 'Medium Price (100-500)'
        ELSE 'High Price (>500)'
    END;
