Create database SecondReviewDB;

Use SecondReviewDB;

-- 1)Use a stored procedure PlaceOrder that adds a new order and updates the product stock.
Create Table Products (
    ProductID int Primary Key Identity(1,1),
    ProductName Varchar(50),
    Stock int
);

Insert into Products (ProductName, Stock) Values 
('Bottle', 50), ('Pen', 100), ('Notebook', 90);

Create Procedure PlaceOrder (@ProductID int,@ProductName Varchar(50), @Stock int)
AS
Begin    
    IF NOT EXISTS(Select 1 From Products Where ProductID = @ProductID)
    Begin
        Insert into Products (ProductName, Stock) Values (@ProductName, @Stock);
		Print 'Product Added';
    end
    ELSE
    Begin
		Update Products Set Stock = @Stock
        Where ProductID = @ProductID;
        Print 'Order Updated!';
    End
End;

Exec PlaceOrder @ProductID = 4, @ProductName = 'Bottle', @Stock = 50;

Select * from Products;


-- 2)Write a stored procedure ProcessPayment that:
--Accepts payment details (customer ID, amount, date).
--Checks if the customer exists.
--Updates the customer’s balance after the payment.
Create Table Customers (
    CustomerID int Primary Key Identity(1,1),
    CustomerName Varchar(50),
    Balance Dec(10,2)
);

Create Table Payments (
    PaymentID int Primary Key Identity(1,1),
    CustomerID int Foreign Key References Customers(CustomerID),
    Amount Decimal(10,2),
    PaymentDate Date
);

Insert Into Customers (CustomerName, Balance) Values 
('Ankit Sharma', 8000),
('Piyush Kumar', 5000),
('Arya', 9000);


Create Procedure ProcessPayment (@CustomerID int, @Amount Decimal(10,2),@PaymentDate Date)
AS
Begin
    
    IF EXISTS (Select 1 From Customers Where CustomerID = @CustomerID)
    Begin
        Insert Into Payments (CustomerID, Amount, PaymentDate) 
        Values (@CustomerID, @Amount, @PaymentDate);

        Update Customers Set Balance = Balance - @Amount
        Where CustomerID = @CustomerID;
    End
    ELSE
    Begin
        Print 'Customer not Available';
    End
End;

Exec ProcessPayment @CustomerID = 1, @Amount = 2000, @PaymentDate = '2025-02-01';

Select * from Customers;
Select * from Payments;


-- 3)Create a trigger on the Employees table that logs any INSERT, UPDATE, or DELETE operations into an EmployeeAudit table, storing old and new values.
Create Table Employees (
    EmployeeID int Primary Key Identity(1,1),
    Name Varchar(50),
    Salary Decimal(10,2)
);

Create Table EmployeeAudit (
    AuditID int Primary Key Identity(1,1),
    EmployeeID int,
    OldName Varchar(50),
    NewName Varchar(50),
    OldSalary Decimal(10,2),
    NewSalary Decimal(10,2),
    Operation Varchar(10),
    OperationDate DateTime Default GETDATE()
);

Create Trigger trg_EmployeeAudit 
ON Employees
After INSERT, UPDATE, DELETE
AS
Begin
    SET NOCOUNT ON;

    Insert into EmployeeAudit (EmployeeID, OldName, NewName, OldSalary, NewSalary, Operation)
    Select 
        i.EmployeeID, 
        NULL, i.Name, 
        NULL, i.Salary, 
        'INSERT'
    From inserted i;

    Insert into EmployeeAudit (EmployeeID, OldName, NewName, OldSalary, NewSalary, Operation)    
    Select 
        d.EmployeeID, 
        d.Name, i.Name, 
        d.Salary, i.Salary, 
        'UPDATE'
    From inserted i
    INNER JOIN deleted d 
    ON i.EmployeeID = d.EmployeeID;

    Insert into EmployeeAudit (EmployeeID, OldName, NewName, OldSalary, NewSalary, Operation)
    Select 
        d.EmployeeID, 
        d.Name, NULL, 
        d.Salary, NULL, 
        'DELETE'
    From deleted d;
END;

-- Checks for Triggers INSERT UPDATE DELETE on Employees
Insert Into Employees(Name, Salary) Values('Piyush',35000);

Update Employees Set Name = 'Ankit' Where EmployeeID=1;

Delete Employees Where EmployeeID = 1;

Select * from EmployeeAudit


-- 4)Use a cursor to iterate through the Payments table and update the CustomerBalance column in the Customers table based on the payments.
Declare @CustomerID int, @Amount decimal(10,2);

Declare Payment_Cursor cursor 
For 
select CustomerID, Amount from Payments;

Open payment_cursor;

Fetch Next From payment_cursor into @CustomerID, @Amount;

While @@FETCH_STATUS = 0
begin
    update Customers set Balance = Balance - @Amount
    where CustomerID = @CustomerID;

    Fetch Next From payment_cursor into @CustomerID, @Amount;
end;

Close payment_cursor;
Deallocate payment_cursor;


-- 5)Write a scalar-valued function CalculateAge that takes a date of birth as input and returns the age in years

Create Function calculateAge (@dob date)  
Returns INT  
as  
Begin  
    Declare @age int;
    Set @age = DATEDIFF(year, @dob, getdate())
    return @age;
end;

Select dbo.calculateAge('2002-01-01') AS Age;

-- 6)Write a function IsValidEmail that accepts an email address and returns 1 if it is valid, 0 otherwise.
Create Function IsValidEmail(@Email Varchar(100))
Returns int
AS
Begin
	If @Email Like '%_@_%._%'
		Begin
			Return 1
		End
	Return 0
End;

Select dbo.IsValidEmail('Piyush@gmail.com') AS IsValid;
Select dbo.IsValidEmail('PiyushKumar') AS IsValid;