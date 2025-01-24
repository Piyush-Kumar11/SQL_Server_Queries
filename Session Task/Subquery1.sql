create database SessionDB

use SessionDB

Create Table Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    CategoryID INT,
    Price DECIMAL(10, 2)
);

Insert Into Products (ProductID, ProductName, CategoryID, Price)
Values 
    (1, 'Laptop', 101, 80000.00),
    (2, 'Smartphone', 101, 40000.00),
    (3, 'Tablet', 101, 30000.00),
    (4, 'Headphones', 102, 2000.00),
    (5, 'Desk', 104, 12000.00);


Create Table Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
);

Insert into Orders (OrderID, CustomerID)
Values 
    (1, 201),
    (2, 202),
    (3, 202),
    (4, 201);

Create Table Customers (
CustomerID INT PRIMARY KEY,
CustomerName VARCHAR(100)
);

Insert Into Customers (CustomerID, CustomerName)
Values 
    (201, 'Piyush'),
    (202, 'Karan'),
    (203, 'Joy'),
    (204, 'Ajay'),
    (205, 'Kumar');

	select * from Products;
	select * from Orders;
	select * from Customers;

--1>Write a query to find all products from the Products table whose price is above the average price of all products.
Select ProductID, ProductName, Price
From Products
Where Price > (Select AVG(Price) From Products)

-- 2>Use a subquery to find the customer who has placed the maximum number of orders in the Orders table. 
Select CustomerID
From Orders
Group BY CustomerID
Having COUNT(OrderID) = (
    Select MAX(order_count)
    From (
        Select COUNT(OrderID) AS order_count
        From Orders
        Group BY CustomerID)AS Query)

-->3>Using a subquery, display the lowest price for each product category from the Products table.
Select DISTINCT P1.CategoryID, P1.Price AS LowestPrice
From Products P1
Where P1.Price = (
    Select MIN(P2.Price)
    From Products P2
    Where P2.CategoryID = P1.CategoryID
)
