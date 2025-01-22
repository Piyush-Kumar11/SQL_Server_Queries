--SELECT Clause Examples
CREATE TABLE Person (
    Id INT PRIMARY KEY IDENTITY(1,1),
    First_Name VARCHAR(20) NOT NULL,
    Last_Name VARCHAR(20) NOT NULL,
    Age INT NOT NULL CHECK (Age > 0),
    State VARCHAR(15) NOT NULL,
    Pincode INT NOT NULL
);

INSERT INTO Person (First_Name, Last_Name, Age, State, Pincode) 
VALUES 
('Piyush', 'Kumar', 24, 'Bihar', 824217),
('Amit', 'Sharma', 30, 'Uttar Pradesh', 201301),
('Priya', 'Singh', 27, 'Maharashtra', 400001),
('Rahul', 'Verma', 22, 'Delhi', 110001),
('Sneha', 'Gupta', 28, 'Karnataka', 560001),
('Anjali', 'Mehta', 26, 'Gujarat', 380001),
('Ravi', 'Patel', 32, 'Rajasthan', 302001),
('Kavya', 'Joshi', 25, 'Haryana', 122001),
('Vikram', 'Chauhan', 29, 'Punjab', 141001),
('Rohit', 'Raj', 23, 'West Bengal', 700001);

SELECT * FROM Person;

Select First_Name From Person;

Select First_Name, Last_Name From Person Where State='Bihar'

Select * From Person Where Age>=24


--ORDER BY Clause
SELECT * FROM Person ORDER BY Age--bY default Ascending order
SELECT * FROM Person ORDER BY Age ASC
SELECT * FROM Person ORDER BY Age DESC

SELECT * FROM Person ORDER BY First_Name,Last_Name

SELECT * FROM Person WHERE Age>25 ORDER BY Pincode

SELECT * FROM Person ORDER BY 4 --4th position is Age in the table
