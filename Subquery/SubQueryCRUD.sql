-- **UPDATE Operations**

-- 1. Increase salary for employees earning below the average salary by 10%
UPDATE Employees
SET salary = salary * 1.10
WHERE salary < (
    SELECT AVG(salary) FROM Employees
);

-- 2. Update department ID for employees whose department is NULL to the ID of the 'Unassigned' department
UPDATE Employees
SET department_id = (
    SELECT department_id
    FROM Departments
    WHERE department_name = 'Unassigned'
)
WHERE department_id IS NULL;

-- 3. Set salaries to the minimum salary in their department if they earn less than it
UPDATE Employees
SET salary = (
    SELECT MIN(salary)
    FROM Employees e2
    WHERE e2.department_id = Employees.department_id
)
WHERE salary < (
    SELECT MIN(salary)
    FROM Employees e2
    WHERE e2.department_id = Employees.department_id
);

-- 4. Increase salaries by 15% for employees in the department with the highest average salary
UPDATE Employees
SET salary = salary * 1.15
WHERE department_id = (
    SELECT TOP 1 department_id
    FROM Employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
);

-- **DELETE Operations**

-- 1. Delete employees earning less than the minimum salary in the 'Marketing' department
DELETE FROM Employees
WHERE salary < (
    SELECT MIN(salary)
    FROM Employees
    WHERE department_id = (
        SELECT department_id
        FROM Departments
        WHERE department_name = 'Marketing'
    )
);

-- 2. Delete departments with no employees assigned
DELETE FROM Departments
WHERE department_id NOT IN (
    SELECT DISTINCT department_id
    FROM Employees
);

-- 3. Delete employees whose salaries are above the maximum salary in the 'IT' department
DELETE FROM Employees
WHERE salary > (
    SELECT MAX(salary)
    FROM Employees
    WHERE department_id = (
        SELECT department_id
        FROM Departments
        WHERE department_name = 'IT'
    )
);

-- 4. Delete all employees who are in the department with the lowest number of employees
DELETE FROM Employees
WHERE department_id = (
    SELECT TOP 1 department_id
    FROM Employees
    GROUP BY department_id
    ORDER BY COUNT(*) ASC
);

-- 5. Delete employees not in any department
DELETE FROM Employees
WHERE department_id NOT IN (
    SELECT department_id
    FROM Departments
);

-- 6. Delete departments where the maximum salary of employees is less than the company average salary
DELETE FROM Departments
WHERE department_id IN (
    SELECT department_id
    FROM Employees
    GROUP BY department_id
    HAVING MAX(salary) < (
        SELECT AVG(salary)
        FROM Employees
    )
);
