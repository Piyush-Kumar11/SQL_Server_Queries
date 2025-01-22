--DDL Command
use DemoDB

Create table DemoPractice(
Id int Primary Key,
Name varchar(25) NOT NULL,
Price decimal(10,2) NOT NULL Check (Price>0),
MFD datetime Not Null
)

ALTER TABLE DemoPractice ALTER COLUMN MFD DATE NOT NULL;

--DML Commands
Insert into DemoPractice(Id,Name,Price,MFD) values(2,'Laptop',2500.25,'2025-11-15 21:30:25')

Delete From DemoPractice where Id = 1

UPDATE DemoPractice SET Price = 2700.00 WHERE Id = 2;

Insert into DemoPractice(Id,Name,Price,MFD) values(3,'Notebook',45.55,'2023-10-20')

--DQL Commands
select * from DemoPractice

SELECT Id, Name, Price FROM DemoPractice;

SELECT * FROM DemoPractice WHERE Price > 1000;

SELECT * FROM DemoPractice ORDER BY Price DESC;

--DCL Commands
-- Grant SELECT permission on DemoPractice table to a user
GRANT SELECT ON DemoPractice TO UserName;

-- Revoke SELECT permission on DemoPractice table from a user
REVOKE SELECT ON DemoPractice FROM UserName;

--TCL Commands
-- Commit the current transaction (save changes)
COMMIT;

-- Rollback the current transaction (undo changes)
ROLLBACK;


