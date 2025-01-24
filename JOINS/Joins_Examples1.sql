use JoinsDB
-- Create the Students table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100)
);

-- Insert sample data for Students
INSERT INTO Students (student_id, name, email) VALUES
(1, 'Alice', 'alice@example.com'),
(2, 'Bob', 'bob@example.com'),
(3, 'Charlie', 'charlie@example.com'),
(4, 'Diana', 'diana@example.com');

-- Create the Courses table
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100)
);

-- Insert sample data for Courses
INSERT INTO Courses (course_id, course_name) VALUES
(101, 'Mathematics'),
(102, 'Physics'),
(103, 'Chemistry'),
(104, 'Biology');

-- Create the Enrollments table
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Insert sample data for Enrollments
INSERT INTO Enrollments (enrollment_id, student_id, course_id) VALUES
(1, 1, 101),
(2, 2, 101),
(3, 3, 102),
(4, 1, 103),
(5, 2, 103);

-- Create the Assignments table
CREATE TABLE Assignments (
    assignment_id INT PRIMARY KEY,
    course_id INT,
    title VARCHAR(100),
    due_date DATE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Insert sample data for Assignments
INSERT INTO Assignments (assignment_id, course_id, title, due_date) VALUES
(1, 101, 'Assignment 1', '2024-01-15'),
(2, 101, 'Assignment 2', '2024-02-10'),
(3, 102, 'Midterm Project', '2024-03-01'),
(4, 103, 'Final Exam', '2024-04-20');

-- Create the Grades table
CREATE TABLE Grades (
    grade_id INT PRIMARY KEY,
    student_id INT,
    assignment_id INT,
    score DECIMAL(5, 2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (assignment_id) REFERENCES Assignments(assignment_id)
);

-- Insert sample data for Grades
INSERT INTO Grades (grade_id, student_id, assignment_id, score) VALUES
(1, 1, 1, 85.5),
(2, 2, 1, 90.0),
(3, 3, 2, 75.0),
(4, 1, 3, 88.0),
(5, 2, 4, 92.0);

-- Create the Instructors table
CREATE TABLE Instructors (
    instructor_id INT PRIMARY KEY,
    course_id INT,
    name VARCHAR(50),
    email VARCHAR(100),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Insert sample data for Instructors
INSERT INTO Instructors (instructor_id, course_id, name, email) VALUES
(1, 101, 'Dr. Smith', 'smith@example.com'),
(2, 102, 'Dr. Johnson', 'johnson@example.com'),
(3, 103, 'Dr. Lee', 'lee@example.com');

-- Create the Attendance table
CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    attendance_date DATE,
    status VARCHAR(10),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Insert sample data for Attendance
INSERT INTO Attendance (attendance_id, student_id, course_id, attendance_date, status) VALUES
(1, 1, 101, '2024-01-10', 'Present'),
(2, 2, 101, '2024-01-10', 'Absent'),
(3, 3, 102, '2024-02-05', 'Present'),
(4, 1, 103, '2024-02-07', 'Absent'),
(5, 2, 103, '2024-02-07', 'Present');

Select * from Students;
Select * from Courses;
Select * from Grades;
Select * from Instructors;
Select * from Assignments;
Select * from Attendance;
Select * from Enrollments;


-- 1) List students along with the names of courses they are enrolled in
SELECT Students.student_id, Students.name AS student_name, 
		Courses.course_id, Courses.course_name
FROM Students
INNER JOIN Enrollments 
ON Students.student_id = Enrollments.student_id
INNER JOIN Courses 
ON Enrollments.course_id = Courses.course_id;

-- 2) List all students and the courses they are enrolled in, including students not enrolled in any course
SELECT Students.student_id, Students.name AS student_name, 
		Courses.course_id, Courses.course_name
FROM Students
LEFT JOIN Enrollments 
ON Students.student_id = Enrollments.student_id
LEFT JOIN Courses 
ON Enrollments.course_id = Courses.course_id;

-- 3) List all courses and the students enrolled in each course, including courses with no students
SELECT Courses.course_id, Courses.course_name, 
		Students.student_id, Students.name AS student_name
FROM Courses
LEFT JOIN Enrollments 
ON Courses.course_id = Enrollments.course_id
LEFT JOIN Students 
ON Enrollments.student_id = Students.student_id;

-- 4) Full Outer Join: List all students and courses, including unmatched records
SELECT Students.student_id, Students.name AS student_name, 
		Courses.course_id, Courses.course_name
FROM Students
FULL JOIN Enrollments 
ON Students.student_id = Enrollments.student_id
FULL JOIN Courses 
ON Enrollments.course_id = Courses.course_id;

-- 5) Retrieve each student's name along with their course name and instructor’s name
SELECT Students.name AS student_name, 
		Courses.course_name, 
		Instructors.name AS instructor_name
FROM Students
INNER JOIN Enrollments 
ON Students.student_id = Enrollments.student_id
INNER JOIN Courses 
ON Enrollments.course_id = Courses.course_id
INNER JOIN Instructors 
ON Courses.course_id = Instructors.course_id;

-- 6) Find students not enrolled in any course
SELECT Students.student_id, Students.name AS student_name
FROM Students
LEFT JOIN Enrollments 
ON Students.student_id = Enrollments.student_id
WHERE Enrollments.course_id IS NULL;

-- 7) Retrieve the title of each assignment along with the student’s name and their score
SELECT Assignments.title AS assignment_title, 
		Students.name AS student_name, 
		Grades.score
FROM Assignments
INNER JOIN Grades 
ON Assignments.assignment_id = Grades.assignment_id
INNER JOIN Students 
ON Grades.student_id = Students.student_id;

-- 8) List each course name, the total number of enrolled students, and the instructor's name
SELECT Courses.course_name, 
		COUNT(Enrollments.student_id) AS total_students, 
		Instructors.name AS instructor_name
FROM Courses
LEFT JOIN Enrollments 
ON Courses.course_id = Enrollments.course_id
INNER JOIN Instructors 
ON Courses.course_id = Instructors.course_id
GROUP BY Courses.course_name, Instructors.name;

-- 9) Calculate the average attendance rate for each course (percentage of "Present" status)
SELECT Courses.course_name,
       AVG(CASE WHEN Attendance.status = 'Present' THEN 1 ELSE 0 END) * 100 AS attendance_rate
FROM Courses
INNER JOIN Attendance 
ON Courses.course_id = Attendance.course_id
GROUP BY Courses.course_name;

-- 10) Find the highest score for each assignment and the student who achieved it
WITH MaxScoresCTE AS (
    SELECT assignment_id, MAX(score) AS max_score
    FROM Grades
    GROUP BY assignment_id
)
SELECT A.title AS assignment_title, 
		S.name AS student_name, 
		G.score AS max_score
FROM Assignments A
JOIN Grades G 
ON A.assignment_id = G.assignment_id
JOIN Students S 
ON G.student_id = S.student_id
JOIN MaxScoresCTE M 
ON G.assignment_id = M.assignment_id AND G.score = M.max_score;
