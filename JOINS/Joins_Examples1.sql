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


----------------------------------------------PART-2----------------------------------------------------------
-- Create Patients Table
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    contact_info VARCHAR(255),
    address TEXT
);

-- Create Doctors Table
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialty VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE
);

-- Create Appointments Table
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATETIME NOT NULL,
    status VARCHAR(50) CHECK (status IN ('Completed', 'Canceled', 'Scheduled')),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) 
);

-- Create MedicalRecords Table
CREATE TABLE MedicalRecords (
    record_id INT PRIMARY KEY,
    patient_id INT,
    notes TEXT,
    diagnosis VARCHAR(255),
    record_date DATE NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- Create Prescriptions Table
CREATE TABLE Prescriptions (
    prescription_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    medication VARCHAR(255) NOT NULL,
    dosage VARCHAR(100) NOT NULL,
    prescription_date DATE NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) 
);

-- Create Payments Table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    appointment_id INT,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATE NOT NULL,
    payment_method VARCHAR(50),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) 
);

-- Inserting Data --
-- Insert Patients
INSERT INTO Patients (patient_id, name, dob, contact_info, address)
VALUES 
(1, 'Amit Sharma', '1995-06-15', '9876543210', 'Delhi'),
(2, 'Priya Verma', '1988-02-10', '7894561230', 'Mumbai'),
(3, 'Rahul Nair', '2001-09-22', '7012345678', 'Bangalore'),
(4, 'Sneha Iyer', '1990-12-05', '8987654321', 'Chennai'),
(5, 'Vikram Mehta', '2005-03-18', '9123456789', 'Kolkata');

-- Insert Doctors
INSERT INTO Doctors (doctor_id, name, specialty, phone, email)
VALUES 
(1, 'Dr. Rajesh Khanna', 'Cardiology', '9822334455', 'rajesh.khanna@hospital.in'),
(2, 'Dr. Manisha Desai', 'Orthopedics', '7896541230', 'manisha.desai@hospital.in'),
(3, 'Dr. Arvind Menon', 'Pediatrics', '7011223344', 'arvind.menon@hospital.in'),
(4, 'Dr. Sunita Rao', 'Neurology', '9123456789', 'sunita.rao@hospital.in');

-- Insert Appointments
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status)
VALUES 
(1, 1, 1, '2024-01-10', 'Completed'),
(2, 2, 1, '2024-01-15', 'Completed'),
(3, 3, 2, '2024-02-20', 'Scheduled'),
(4, 4, 3, '2024-03-05', 'Completed'),
(5, 5, 3, '2024-03-10', 'Completed'),
(6, 2, 4, '2024-04-15', 'Canceled'),
(7, 3, 1, '2024-05-18', 'Completed');

-- Insert Medical Records
INSERT INTO MedicalRecords (record_id, patient_id, notes, diagnosis, record_date)
VALUES 
(1, 1, 'Mild chest pain', 'Hypertension', '2024-01-11'),
(2, 2, 'Irregular heartbeat', 'Arrhythmia', '2024-01-16'),
(3, 3, 'Knee pain', 'Ligament tear', '2024-02-21'),
(4, 4, 'Fever and weakness', 'Viral infection', '2024-03-06'),
(5, 5, 'Growth monitoring', 'Normal development', '2024-03-11');

-- Insert Prescriptions
INSERT INTO Prescriptions (prescription_id, patient_id, doctor_id, medication, dosage, prescription_date)
VALUES 
(1, 1, 1, 'Aspirin', '1 tablet daily', '2024-01-11'),
(2, 2, 1, 'Metoprolol', '50mg daily', '2024-01-16'),
(3, 3, 2, 'Ibuprofen', '400mg as needed', '2024-02-21'),
(4, 4, 3, 'Paracetamol', '500mg twice daily', '2024-03-06'),
(5, 5, 3, 'Vitamin D', '2000 IU daily', '2024-03-11');

-- Insert Payments
INSERT INTO Payments (payment_id, appointment_id, amount, payment_date, payment_method)
VALUES 
(1, 1, 1500, '2024-01-10', 'Credit Card'),
(2, 2, 2000, '2024-01-15', 'UPI'),
(3, 4, 1000, '2024-03-05', 'Cash'),
(4, 5, 1200, '2024-03-10', 'Debit Card'),
(5, 7, 1800, '2024-05-18', 'Net Banking');

-- 1)Retrieve a list of patients who have had an appointment with a doctor specializing in "Cardiology".
Select p.name, p.patient_id, p.dob, p.contact_info, p.address, a.appointment_date, a.status, d.name AS 'Doctor_Name'
From Patients p
Inner Join Appointments a ON p.patient_id = a.patient_id
Inner Join Doctors d ON a.doctor_id = d.doctor_id
Where d.specialty = 'Cardiology';

-- 2)Create a list of all patients and doctors along with their names and a designation ("Patient" or "Doctor").
SELECT name AS person_name, 'Patient' AS designation FROM Patients
UNION ALL
SELECT name AS person_name, 'Doctor' AS designation FROM Doctors;

-- 3)Retrieve each doctor’s name and the average number of appointments per month.
SELECT Doctors.name AS doctor_name,
       COUNT(Appointments.appointment_id) / 
       (DATEDIFF(MONTH, MIN(Appointments.appointment_date), MAX(Appointments.appointment_date)) + 1) AS avg_appointments_per_month
FROM Doctors
JOIN Appointments ON Doctors.doctor_id = Appointments.doctor_id
GROUP BY Doctors.name;

-- 4)Retrieve each patient’s name along with their most recent diagnosis.
SELECT P.name, M.diagnosis
FROM Patients P
JOIN MedicalRecords M ON P.patient_id = M.patient_id
WHERE M.record_date = (SELECT MAX(record_date) FROM MedicalRecords WHERE patient_id = P.patient_id);

-- 5)Create a combined list of patients and doctors who are either under 30 (patients) or specialize in "Pediatrics" (doctors).
SELECT name, 'Patient' AS designation FROM Patients
WHERE DATEDIFF(YEAR, dob, GETDATE()) < 30
UNION
SELECT name, 'Doctor' AS designation FROM Doctors
WHERE specialty = 'Pediatrics';

-- 6)List all doctors who have more than 20 completed appointments.
SELECT D.name, COUNT(A.appointment_id) AS total_appointments
FROM Doctors D
JOIN Appointments A ON D.doctor_id = A.doctor_id
WHERE A.status = 'Completed'
GROUP BY D.name
HAVING COUNT(A.appointment_id) > 20;

-- 7)Find all patients who have at least one prescription for "Ibuprofen" issued by a doctor specializing in "Orthopedics".
SELECT DISTINCT P.name 
FROM Patients P
JOIN Prescriptions PR ON P.patient_id = PR.patient_id
JOIN Doctors D ON PR.doctor_id = D.doctor_id
WHERE PR.medication = 'Ibuprofen' AND D.specialty = 'Orthopedics';

-- 8)Find patients who share the same doctor.
SELECT p1.name AS patient1, p2.name AS patient2, Doctors.name AS shared_doctor
FROM Appointments AS a1
JOIN Appointments AS a2 ON a1.doctor_id = a2.doctor_id AND a1.patient_id < a2.patient_id
JOIN Patients AS p1 ON a1.patient_id = p1.patient_id
JOIN Patients AS p2 ON a2.patient_id = p2.patient_id
JOIN Doctors ON a1.doctor_id = Doctors.doctor_id;

-- 9)Calculate the average payment amount per appointment.
SELECT AVG(amount) AS avg_payment_per_appointment 
FROM Payments;

-- 10)Retrieve each doctor's name and the date of their most recent appointment.
SELECT D.name, MAX(A.appointment_date) AS latest_appointment 
FROM Doctors D
JOIN Appointments A ON D.doctor_id = A.doctor_id
GROUP BY D.name;
