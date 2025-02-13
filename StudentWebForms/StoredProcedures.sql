create database StudentsWebForms

use StudentsWebForms

Create Table Students(
	StudentID int Identity(1,1) Primary Key,
	Name Varchar(50) Not Null,
	Age int Check(Age>0),
	Email Varchar(50) Unique Not Null,
	EnrollmentDate Datetime Default GetDate()
);

CREATE PROCEDURE sp_insertStudent(@name Varchar(50), @age INT, @email Varchar(50))
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Students WHERE email = @email)
    BEGIN
        INSERT INTO Students (name, age, email)
        VALUES (@name, @age, @email);
    END
END;

CREATE PROCEDURE sp_getAllStudents
AS
BEGIN
    SELECT * FROM Students;
END;

CREATE PROCEDURE sp_getStudentById(@studentId INT)
AS
BEGIN
    SELECT * FROM Students WHERE studentId = @studentId;
END;

CREATE PROCEDURE sp_updateStudent(@studentId INT, @name Varchar(50), @age INT, @email Varchar(50))
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Students WHERE studentId = @studentId)
    BEGIN
        UPDATE Students
        SET name = @name, age = @age, email = @email
        WHERE studentId = @studentId;
    END
END;

CREATE PROCEDURE sp_deleteStudent( @studentId INT)
AS
BEGIN
    DELETE FROM Students WHERE studentId = @studentId;
END;

select * from Students