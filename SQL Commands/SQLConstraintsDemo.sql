CREATE TABLE Student (
    Name VARCHAR(25) NOT NULL,             -- Name of the student (cannot be NULL)
    RollNo INT PRIMARY KEY,                -- Roll number of the student (Primary Key)
    Address VARCHAR(50) NOT NULL,          -- Address of the student (cannot be NULL)
    Age INT NOT NULL CHECK (Age > 0),      -- Age of the student (must be a positive integer)
    DateOfBirth DATE,                      -- Date of birth of the student
    Gender CHAR(1) DEFAULT 'U',            -- Gender with default value (Unknown)
    Email VARCHAR(50) UNIQUE               -- Unique email address of the student
);

Select * from Student

Insert into Student(Name,RollNo,Address,Age,DateOfBirth,Gender,Email) 
VALUES('Ankit',21,'Gaya-Bihar',24,'2001-09-05','M','ankit@gmail.com')

Insert into Student(Name,RollNo,Address,Age,DateOfBirth,Email) 
VALUES('Karan',05,'Patna-Bihar',20,'2005-02-01','karan@gmail.com')
