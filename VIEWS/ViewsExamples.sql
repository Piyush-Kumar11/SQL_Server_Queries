Use UserDB;

-- Instead of writing this
Select s.StudentName, g.Grade
from Students s
Join Grades g
On s.StudentID = g.StudentID;


-- We can use View for this operation
Create View studentsWithGrades
AS
	Select s.StudentName, g.Grade
	from Students s
	Join Grades g
	On s.StudentID = g.StudentID;

-- Using a View 
Select * from studentsWithGrades;

create view orderDetailsWithOrder
as
	select o.CustomerName, o.totalAmount, c.ProductName, c.Quantity, c.Price
	from Orders o
	join OrderDetails c
	on o.OrderID = c.OrderID;

Select * from orderDetailsWithOrder

-- Renaming a View
Exec sp_rename 'studentsWithGrades','studentsAndGrades';

-- List all Views
Select name from sys.views;

-- View Metadata
Exec sp_helptext 'studentsAndGrades';

-- Creating a View with Aggregation
create view averageGradePerStudent
as
	select s.studentName, avg(g.grade) as averageGrade
	from students s
	join grades g
	on s.studentID = g.studentID
	group by s.studentName;

select * from averageGradePerStudent;

-- Creating an Indexed View (Materialized View)
create view indexedStudentGrades
with schemabinding
as
	select s.studentID, s.studentName, g.grade
	from dbo.students s
	join dbo.grades g
	on s.studentID = g.studentID;

-- Creating a Unique Clustered Index on the Indexed View
create unique clustered index idx_studentGrades 
on indexedStudentGrades(studentID);

-- Using Indexed View
select * from indexedStudentGrades;
