create Database FirstReviewDB
use FirstReviewDB

--1Basic Employee Management-----------------------------------------
Create Table Employees(
	EmployeeID int Primary Key,
	Name varchar(25) NOT NULL,
	Age int Not Null,
	Department varchar(25) NOT NULL,
	Salary int Not Null
);

--Insert 5 sample employee records.
Insert into Employees (EmployeeID, Name, Age, Department, Salary)
Values 
    (1, 'Piyush', 24, 'IT', 35000),
    (2, 'Ayush', 15, 'HR', 30000),
    (3, 'Sneha', 28, 'Finance', 45000),
    (4, 'Raj', 32, 'Operations', 40000),
    (5, 'Anjali', 26, 'Marketing', 38000);

--Update the salary of an employee with EmployeeID = 3.
Update Employees Set Salary=salary+500 Where EmployeeID=3;

--Delete an employee whose Name = 'John Doe'.
Delete From Employees Where Name = 'Anjali';

--Retrieve all employee records.
Select * From Employees;

--2.Student Management System------------------------------------------------
--Create a Students table with columns: StudentID, Name, Class, DOB, and Grade.
Create table Students (
	StudentID int Primary Key Identity(1,1),
	Name varchar(25) Not Null,
	Class int Not Null,
	DOB Date Not Null,
	Grade char Not Null
)

--Insert records for 10 students.
Insert Into Students (Name, Class, DOB, Grade)
Values 
    ('Piyush', 9, '2005-05-15', 'A'),
    ('Ayush', 10, '2004-07-20', 'B'),
    ('Sneha', 8, '2006-03-10', 'A'),
    ('Raj', 10, '2004-09-25', 'C'),
    ('Anjali', 9, '2005-11-18', 'A'),
    ('Rohit', 7, '2007-01-30', 'B'),
    ('Meena', 8, '2006-12-12', 'A'),
    ('Vikram', 10, '2004-04-05', 'C'),
    ('Sonia', 7, '2007-06-06', 'B'),
    ('Kiran', 9, '2005-08-22', 'A');

--Update the Grade of a student with StudentID = 5.
Update Students
SET Grade = 'B'
where StudentID = 5;

--Delete all students who belong to Class = '10th'.
DELETE FROM Students
WHERE Class = 10;

--3.Product Inventory-------------------------------------------------
--Create a Products table with columns: ProductID, ProductName, Price, Stock.
Create Table Products (
    ProductID int PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(50) NOT NULL,
    Price decimal(10, 2) NOT NULL,
    Stock int NOT NULL
);

--Insert 7 sample products into the table.
Insert into Products (ProductName, Price, Stock)
Values
    ('Laptop', 50000, 10),
    ('Smartphone', 20000, 15),
    ('Tablet', 15000, 7),
    ('Smartwatch', 10000, 3),
    ('Headphones', 3000, 20),
    ('Keyboard', 1500, 8),
    ('Mouse', 1000, 2);

--Increase the price of all products by 10%.
Update Products
SET Price = Price * 1.10;

--Delete products where the stock is below 5.
Delete From Products
Where Stock < 5;

--4)Create a Users table with columns: UserID, Username, Email, and Password.--------------
--Apply constraints:
--Make UserID the primary key.
--Ensure Email is unique.
--Ensure Password has a minimum length of 8 characters.
--Write SQL queries to test these constraints by inserting and updating data.
Create Table Users (
    UserID int PRIMARY KEY IDENTITY(1,1),
    Username VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL unique,
    Password VARCHAR(50) NOT NULL check (LEN(Password) >= 8)
);

--Valid Data Inserion
Insert into Users (Username, Email, Password)
Values 
    ('Piyush', 'piyushkumar@gmail.com', 'password123'),
    ('Ayush', 'ayush@gmail.com', 'Ayush124'),
    ('Sneha', 'sneha@gmail.com', 'pass12345');

--Invalid Data Insertion
--For Duplicate Email
Insert into Users (Username, Email, Password)
values ('Karan', 'piyushkumar@gmail.com', 'karan123');
--ERROR: Violation of UNIQUE KEY constraint 'UQ__Users__A9D105342FE67DDA'. Cannot insert duplicate key in object 'dbo.Users'. The duplicate key value is (piyushkumar@gmail.com).

--For Password length
Insert into Users (Username, Email, Password)
values ('Jay', 'jay@gmail.com', 'jay25');
--ERROR: The INSERT statement conflicted with the CHECK constraint "CK__Users__Password__656C112C". The conflict occurred in database "FirstReviewDB", table "dbo.Users", column 'Password'.

--5)Create a Departments table (DepartmentID, DepartmentName) and an Employees table (EmployeeID, Name, DepartmentID).-----------------------------
--Add a foreign key constraint on DepartmentID in Employees referencing Departments.
--Insert valid and invalid records to test the constraint.
Create table Departments (
    DepartmentID int PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);

Create table Employees (
    EmployeeID int PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50) NOT NULL,
    DepartmentID INT NOT NULL,
    constraint Fkey_Department Foreign Key (DepartmentID) References Departments(DepartmentID)
);

Insert into Departments (DepartmentID, DepartmentName)
Values 
    (1, 'HR'),
    (2, 'IT'),
    (3, 'Finance');

--Test Valid data
Insert into Employees (Name, DepartmentID)
Values ('Piyush', 2);

--Test Invalid Data
Insert into Employees (Name, DepartmentID)
Values ('Ayush', 5);

--6)Create a Products table with a column Price.-----------------------------------------
--Add a check constraint to ensure the Price is always greater than 0.
--Test the constraint by inserting valid and invalid data.
Create Table Products (
    ProductID int PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(50) NOT NULL,
    Price decimal(10, 2) NOT NULL check (Price > 0)
);

--Valid Data insertion
Insert into Products (ProductName, Price)
Values 
    ('Laptop', 50000.00),
    ('Smartphone', 20000.00),
    ('Tablet', 15000.00);

--Invalid Data Insertion
Insert into Products (ProductName, Price)
Values ('Headphones', 0.00);

Insert into Products (ProductName, Price)
Values ('Notebook', -250.00);

--7)Create a Books table with columns: BookID, Title, and Author.------------------------
Create Table Books(
BookID int PRIMARY KEY,
Title VARCHAR(30) NOT NULL,
Author VARCHAR(30) NOT NULL
);
--Add a new column PublicationYear to the table.
Alter Table Books
Add PublicationYear int;

--Modify the Author column to have a maximum length of 150 characters.
Alter Table Books
Alter Column Author VARCHAR(150) NOT NULL;

--Drop the PublicationYear column.
Alter Table Books
Drop Column PublicationYear;

--8)Create a Customers table with columns: CustomerID, Name, and Phone.
Create Table Customers (
    CustomerID int PRIMARY KEY,
    Name VARCHAR(25) NOT NULL,
    Phone bigint NOT NULL
);

--Rename the column Phone to ContactNumber.
Alter Table Customers
Change Phone ContactNumber;

--Change the data type of ContactNumber to VARCHAR(15).
Alter Table Customers
Alter Column Phone Varchar(15) NOT NULL;

--9)Create an Employees table with columns: EmployeeID, Name, Age, and Salary.-----------------
Create Table Employees(
	EmployeeID int Primary Key IDENTITY(1,1),
	Name varchar(25) NOT NULL,
	Age int Not Null,
	Salary int Not Null
);
--Write queries to:
--Retrieve all employees with a salary greater than 50,000.
Select *
From Employees
Where Salary>50000;

--Retrieve all employees whose names start with the letter ‘A’.
Select *
From Employees
Where Name Like 'A%';

--Retrieve employees aged between 25 and 35.
Select *
From Employees
Where Age Between 25 And 35;

--10)Create a Sales table with columns: SaleID, ProductID, Quantity, and SaleDate.--------------------
Create Table Sales(
	SaleID int Primary Key,
	ProductID int,
	Quantity int Not Null,
	SaleDate Date Not Null
);

--Write queries to:
--Group sales by ProductID and calculate total quantity sold for each product.
Select ProductId, Sum(Quantity) AS Total_Item
From Sales
Group By ProductID

--Filter out products with total sales less than 50 using the HAVING clause.
Select ProductID, SUM(Quantity) AS Total_Item
From Sales
Group By ProductID
Having SUM(Quantity)<=50


--11)Create an Orders table with columns: OrderID, CustomerID, OrderAmount, OrderDate.-----------------
Create Table Orders(
	OrderID int Primary Key,
	CustomerID int NOT NULL,
	OrderAmount int Not Null,
	OrderDate Date Not Null
);

--Retrieve all orders sorted by OrderAmount in descending order.
Select *
From Orders
Order By OrderAmount DESC;

--Retrieve the top 5 most recent orders.
Select Top 5 *
From Orders
Order By OrderDate Desc;


--12)Create two tables: Customers (CustomerID, Name) and Orders (OrderID, CustomerID, OrderDate, Amount).------------------
--Write an inner join query to retrieve all orders along with the customer names.
Select o.OrderID, o.OrderDate, o.OrderAmount, c.Name AS Customer_Name
From Orders o
Inner Join Customers c
On o.CustomerID = c.CustomerID;


--13)Create two tables: Products (ProductID, ProductName) and OrderDetails (OrderDetailID, ProductID, Quantity).--------------
Create Table OrderDetails(
	OrderDetailID int Primary Key,
	ProductID int NOT NULL,
	Quantity int Not Null,
);

--Write a left join query to retrieve all products, including those that have no orders.
Select p.ProductID, p.ProductName, od.OrderDetailID, od.Quantity
From Products p
Left Join OrderDetails od
On p.ProductID = od.ProductID;


--14)Create two tables: Employees (EmployeeID, Name) and Projects (ProjectID, EmployeeID, ProjectName).
Create Table Projects(
	ProjectID int Primary Key,
	EmployeeID int NOT NULL,
	ProjectName Varchar(50) Not Null,
);

--Write a right join query to retrieve all projects and their assigned employees.
Select e.Name AS Employee_Name, pr.ProjectName
From Employees e
Right Join Projects pr
ON e.EmployeeID = pr.EmployeeID;
