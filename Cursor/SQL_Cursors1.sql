use DemoDB;

-- Creating a table
Create Table Employee(
	ID varchar(10) Not Null,
	Name Varchar(25) Not Null,
	Graduation Varchar(2) Not Null,
	Email Varchar(50) Not Null Unique,
	Phone bigInt Not Null Unique,
	Salary int Not Null Check(Salary>0)
);

--Renaming column
EXEC sp_rename 'Employee.Graduation', 'Department', 'COLUMN';

INSERT INTO Employee (ID, Name, Department, Email, Phone, Salary) VALUES
    (' ', 'Arjun Mehta', 'CS', 'arjun.mehta@gmail.com', 9876543210, 50000),
    (' ', 'Priya Sharma', 'IT', 'priya.sharma@gmail.com', 9123456780, 55000),
    (' ', 'Rahul Verma', 'ME', 'rahul.verma@gmail.com', 9234567890, 60000),
    (' ', 'Aisha Nair', 'EE', 'aisha.nair@gmail.com', 9345678901, 62000),
    (' ', 'Vikram Reddy', 'EC', 'vikram.reddy@gmail.com', 9456789012, 58000),
    (' ', 'Sneha Iyer', 'CS', 'sneha.iyer@gmail.com', 9567890123, 53000),
    (' ', 'Rohan Patel', 'IT', 'rohan.patel@gmail.com', 9678901234, 59000),
    (' ', 'Kavita Singh', 'ME', 'kavita.singh@gmail.com', 9789012345, 57000),
    (' ', 'Manoj Kulkarni', 'EE', 'manoj.kulkarni@gmail.com', 9890123456, 61000),
    (' ', 'Deepika Choudhary', 'EC', 'deepika.choudhary@gmail.com', 9901234567, 54000);

	Select * from Employee;

-- Creating Cursor to Update IDs As JSP(Company Name)+25(Year)+000+EE(Department)
	Declare
		@Department Varchar(2),
		@Year int,
		@Phone bigInt

	Set @Year = Right(Year(GetDate()),2);

	Declare AddIdsForEmployee Cursor
	For
		Select Department, Phone, @Year
		From Employee

	Open AddIdsForEmployee

	Fetch Next From AddIdsForEmployee into @Department, @Phone, @Year

	While @@FETCH_STATUS = 0
		BEGIN
			Declare @ID varchar(10)
				Set @ID = 'JSP' + CAST(@Year As Varchar(2))+'000'+CAST(@Department As Varchar(2))

				Update Employee Set ID = @ID Where Phone = @Phone
			Fetch next from AddIdsForEmployee into @Department, @Phone, @Year
		END
	Close AddIdsForEmployee
	Deallocate AddIdsForEmployee

-- Creating Cursor to Update Salaries based On Department
	Declare 
		@ID varchar(10),
		@Department Varchar(2),
		@NewSalary int,
		@OldSalary INT

	Declare updateSalary Cursor For
	Select ID, Department,Salary From Employee

	Open updateSalary

	Fetch Next From updateSalary into @ID, @Department, @OldSalary

	While @@FETCH_STATUS = 0
	Begin
		IF @Department = 'CS'
			SET @NewSalary = @OldSalary + (@OldSalary * 35 / 100)
		ELSE IF @Department = 'IT'
			SET @NewSalary = @OldSalary + (@OldSalary * 30 / 100)
		ELSE IF @Department = 'ME' OR @Department = 'EE' OR @Department = 'EC'
			SET @NewSalary = @OldSalary + (@OldSalary * 28 / 100)
		ELSE
			SET @NewSalary = @OldSalary

		Update Employee
		Set Salary = @NewSalary
		Where ID = @ID

		FETCH NEXT FROM updateSalary INTO @ID, @Department, @OldSalary
	END
	CLOSE updateSalary
	DEALLOCATE updateSalary

-- Add ExperienceLevel Column to the Employee Table
ALTER TABLE Employee ADD ExperienceLevel VARCHAR(20);

-- Cursor to Add Experience Level for each employee
	DECLARE 
		@ID VARCHAR(10),
		@Salary INT,
		@ExperienceLevel VARCHAR(20)

	DECLARE expCursor CURSOR FOR
	SELECT ID, Salary FROM Employee

	OPEN expCursor

	FETCH NEXT FROM expCursor INTO @ID, @Salary

	WHILE @@FETCH_STATUS = 0
	BEGIN
		-- Assign Experience Level Based on Salary
		IF @Salary >= 100000
			SET @ExperienceLevel = 'Senior'
		ELSE IF @Salary BETWEEN 50000 AND 99999
			SET @ExperienceLevel = 'Mid-Level'
		ELSE
			SET @ExperienceLevel = 'Junior'

		UPDATE Employee 
		SET ExperienceLevel = @ExperienceLevel
		WHERE ID = @ID

		FETCH NEXT FROM expCursor INTO @ID, @Salary
	END

	CLOSE expCursor
	DEALLOCATE expCursor