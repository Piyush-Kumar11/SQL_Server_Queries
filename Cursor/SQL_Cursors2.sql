USE DemoDB;

-- Creating the Students table
CREATE TABLE Students  
(  
    Id INT PRIMARY KEY IDENTITY(1,1),  
    RollNo INT,  
    EnrollmentNo NVARCHAR(15), 
    Name NVARCHAR(50),  
    Branch NVARCHAR(50),  
    University NVARCHAR(50)  
); 

-- Inserting sample student data
INSERT INTO Students  
        ( RollNo, EnrollmentNo, Name, Branch, University )  
VALUES  
    ( 21, '', 'Nikunj Satasiya', 'CE', 'RK University' ),  
    ( 15, '', 'Hiren Dobariya', 'CE', 'RK University' ),  
    ( 12, '', 'Sapna Patel', 'IT', 'RK University' ),  
    ( 18, '', 'Vivek Ghadiya', 'CE', 'RK University' ),  
    ( 22, '', 'Pritesh Dudhat', 'CE', 'RK University' ),  
    ( 08, '', 'Hardik Goriya', 'EC', 'RK University' ),  
    ( 06, '', 'Sneh Patel', 'ME', 'RK University' ); 

-- Declaring variables for cursor
DECLARE @Id INT,  
        @RollNo INT,  
        @Branch NVARCHAR(50),  
        @Year AS INT;  

-- Getting the last two digits of the current year
SET @Year = RIGHT(YEAR(GETDATE()), 2);  

-- Declaring a cursor to generate Enrollment Numbers
	DECLARE AddEnrollmentID CURSOR  
	FOR  
		SELECT Id, Branch, RollNo, @Year FROM Students;  

	OPEN AddEnrollmentID;

	FETCH NEXT FROM AddEnrollmentID INTO @Id, @Branch, @RollNo, @Year;  

	WHILE @@FETCH_STATUS = 0  
	BEGIN  
		DECLARE @EnrollmentNo NVARCHAR(15);  

		-- Generating enrollment number in the format: GDA[Year][Branch]000[RollNo]
		SET @EnrollmentNo = 'GDA' + CAST(@Year AS VARCHAR(2)) + CAST(@Branch AS NVARCHAR(50)) + '000' + CAST(@RollNo AS NVARCHAR(10));  

		-- Updating the Students table with the generated enrollment number
		UPDATE Students  
		SET EnrollmentNo = @EnrollmentNo  
		WHERE Id = @Id;  

		FETCH NEXT FROM AddEnrollmentID INTO @Id, @Branch, @RollNo, @Year;  
	END;  

	CLOSE AddEnrollmentID;  
	DEALLOCATE AddEnrollmentID;  

-- Cursor for Assigning Scholarships Based on Branch
-- Adding a new column for Scholarship Amount
ALTER TABLE Students ADD ScholarshipAmount INT;  

	DECLARE @ScholarshipAmount INT,
			@Id int,
			@Branch NVARCHAR(50);  

	DECLARE AssignScholarship CURSOR  
	FOR  
		SELECT Id, Branch FROM Students;  

	OPEN AssignScholarship;  

	FETCH NEXT FROM AssignScholarship INTO @Id, @Branch;  

	WHILE @@FETCH_STATUS = 0  
	BEGIN  
		IF @Branch = 'CE'  
			SET @ScholarshipAmount = 50000;  
		ELSE IF @Branch = 'IT'  
			SET @ScholarshipAmount = 45000;  
		ELSE IF @Branch = 'EC' OR @Branch = 'ME'  
			SET @ScholarshipAmount = 40000;  
		ELSE  
			SET @ScholarshipAmount = 35000;  

		UPDATE Students  
		SET ScholarshipAmount = @ScholarshipAmount  
		WHERE Id = @Id;  

		FETCH NEXT FROM AssignScholarship INTO @Id, @Branch;  
	END;  

	CLOSE AssignScholarship;  
	DEALLOCATE AssignScholarship;  

SELECT * FROM Students;  
