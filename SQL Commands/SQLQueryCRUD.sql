--CRUD Operations Basic

-- Insert a new student record
INSERT INTO Student (Name, RollNo, Address, Age, DateOfBirth, Email)
VALUES ('Karan', 2, 'Patna-Bihar', 20, '2005-02-01', 'karan@gmail.com');

-- Insert another student with default Gender and EnrollmentDate.
INSERT INTO Student (Name, RollNo, Address, Age, DateOfBirth, Email, Gender)
VALUES ('Ananya', 2, 'Delhi', 22, '2003-10-15', 'ananya@gmail.com', 'F');

SELECT * FROM Student;

SELECT Name FROM Student WHERE Gender = 'F';

SELECT * FROM Student ORDER BY Age;

UPDATE Student
SET Address = 'Mumbai-Maharashtra'
WHERE RollNo = 5;

UPDATE Student
SET Age = 21, Email = 'karan_updated@gmail.com'
WHERE RollNo = 5;

DELETE FROM Student
WHERE RollNo = 2;

--Delete All Records
DELETE FROM Student;

