Use UserDB;

Select * From Students;

Alter Procedure spUpdateAndInsertStudent(@StudentID int, @StudentName Varchar(25))
AS
BEGIN
	IF NOT EXISTS (Select 1 From Students Where StudentID = @StudentID)
		BEGIN
			INSERT INTO Students(StudentName) Values(@StudentName);
			Print 'Student Data Not Exists, Data Inserted Success';
		END
	ELSE
		BEGIN
			Update Students
			Set StudentName = @StudentName
			Where StudentID = @StudentID;
			Print 'Student Exists, Data Updated';
		END
END;

EXEC spUpdateAndInsertStudent @StudentID = 5, @StudentName = 'Piyush';