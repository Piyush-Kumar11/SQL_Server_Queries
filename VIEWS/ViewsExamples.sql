Use UserDB;

Select s.StudentName, g.Grade
from Students s
Join Grades g
On s.StudentID = g.StudentID;


--We can use View for this operation
Create View studentsWithGrades
AS
	Select s.StudentName, g.Grade
	from Students s
	Join Grades g
	On s.StudentID = g.StudentID;

Select * from studentsWithGrades;