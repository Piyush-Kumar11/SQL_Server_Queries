-- 1. Self join to find employees in the same department
SELECT e1.employee_name AS Employee_1, e2.employee_name AS Employee_2, e1.department_id
FROM employees e1
INNER JOIN employees e2
ON e1.department_id = e2.department_id  -- Match employees in the same department
AND e1.employee_id <> e2.employee_id     -- Ensure different employees are paired
ORDER BY e1.department_id, e1.employee_name;

-- 2. Self join to find employees in different departments
SELECT e1.employee_name AS Employee_1, e2.employee_name AS Employee_2
FROM employees e1
INNER JOIN employees e2
ON e1.department_id <> e2.department_id   -- Match employees in different departments
ORDER BY e1.employee_name;

-- 3. Self join to list employees along with their department names
SELECT e.employee_name, d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id   -- Match employees with departments
ORDER BY e.employee_name;

-- 5. Self join to count employees in each department
SELECT e1.department_id, d.department_name, COUNT(e1.employee_id) AS Employee_Count
FROM employees e1
INNER JOIN departments d
ON e1.department_id = d.department_id   -- Match employees with their department
GROUP BY e1.department_id, d.department_name
ORDER BY Employee_Count DESC;

-- 6. Self join using LEFT JOIN to find employees along with their departments, including those without departments
SELECT e1.employee_name AS Employee, d.department_name
FROM employees e1
LEFT JOIN departments d
ON e1.department_id = d.department_id   -- Match employees with departments
ORDER BY e1.employee_name;
