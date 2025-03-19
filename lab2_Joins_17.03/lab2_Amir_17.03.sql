-- 							   LAB 2  -  JOINS
SELECT
	*
FROM
	departments
/*
1. INNER JOIN
Select employee names, salaries, and their respective department names.
Only include employees assigned to a department.
*/

SELECT
	e.first_name,e.last_name, e.salary, d.department_name
FROM
	employees AS e	INNER JOIN 	departments AS d
	ON
	e.department_id = d.department_id;

/*
2. LEFT JOIN
List all employees along with their department names. Show 'Unassigned'
for employees without a department.
*/

SELECT
	e.first_name,
	CASE 
		WHEN d.department_name IS NULL THEN 'Unassigned'
		ELSE d.department_name
	END	AS department_name
FROM
	employees AS e	LEFT JOIN	departments AS d
	ON
	e.department_id = d.department_id;


-- ANOTHER WAY OF DOING THAT
SELECT
	e.first_name, 
	COALESCE(department_name, 'Unassigned')
FROM
	employees AS e	LEFT JOIN	departments AS d
	ON
	e.department_id = d.department_id;

/*
3. RIGHT JOIN
Display each department name along with employee names. Include
departments that have no employees.
*/

SELECT
	d.department_name, e.first_name
FROM
	employees AS e 	RIGHT JOIN	departments AS d
	ON
	e.department_id = d.department_id
ORDER BY
	d.department_name;

/*
4. FULL OUTER JOIN
Select all employees and all departments, including employees without
departments and departments without employees.
*/

SELECT
	e.first_name, d.department_name
FROM
	employees AS e FULL OUTER JOIN	departments AS d
	ON
	e.department_id = d.department_id;

/*
5. CROSS JOIN
Create a query to show all possible combinations of employee names and
department names.
*/

SELECT
	e.first_name, d.department_name
FROM
	employees AS e	
	CROSS JOIN	
	departments AS d ;
-- Checking the number of departments
SELECT
	COUNT(DISTINCT d.department_name) AS count_departments
FROM
	departments AS d;

/*
6. SELF JOIN
Using a self join, write a query to display each employee along with their
manager's name. For employees without a manager, display 'No Manager'.
*/

-- FINDING THE MANAGERS MATCHING TO THE MANAGER_ID(TABLE 1) WITH EMPLOYEE_ID (TABLE 2)
SELECT
	e1.employee_id AS employee, e2.employee_id AS manager
FROM
	employees AS e1 INNER JOIN employees AS e2
	ON e1.employee_id = e2.manager_id;
	
-- DISPLAYING EACH EMPLOYEE ALONG WITH THEIR MANAGER'S NAME

SELECT
	e1.employee_id,
	e1.first_name AS employee,
	e1.last_name,
	e2.employee_id,
	COALESCE(e2.first_name, 'No manager') AS manager,
	e2.last_name
FROM
	employees AS e1
	LEFT JOIN
	employees AS e2
	ON
	e1.employee_id = e2.manager_id
ORDER BY
	manager, e2.last_name;
/*
7. INNER JOIN with Condition
Select employees whose salary is above the average salary of their
department.
*/

SELECT 
    e1.employee_id,
    e1.first_name,
    e1.last_name,
    e1.salary,
    d.department_name
FROM employees AS e1
INNER JOIN employees AS e2
    ON e1.department_id = e2.department_id
INNER JOIN departments AS d
    ON e1.department_id = d.department_id
GROUP BY e1.employee_id, e1.first_name, e1.last_name, e1.salary, d.department_name
HAVING e1.salary > AVG(e2.salary)
ORDER BY d.department_name, e1.salary DESC;
	
/*
8. LEFT JOIN with Aggregation
Calculate the average salary for each department. Include departments
with no employees, showing a count of 0 and an average salary as 'NULL'.
*/

SELECT 
    d.department_name,
    COUNT(e.employee_id) AS employee_count,
    ROUND(AVG(e.salary),2) AS avg_salary
FROM departments AS d
LEFT JOIN employees AS e
    ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY d.department_name;

/*
9. RIGHT JOIN with Aggregation
Count the number of employees in each department, including
departments with no employees. Sort by the number of employees in
descending order.
*/

SELECT 
    d.department_name,
    COUNT(e.employee_id) AS employee_count
FROM employees AS e
RIGHT JOIN departments AS d
    ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY employee_count DESC;

/*
10. FULL OUTER JOIN with Advanced Conditions
Write a query to select all employees and department names, including
employees without departments and departments without employees.
Display a meaningful placeholder for missing data.
*/

SELECT 
    COALESCE(e.first_name || ' ' || e.last_name, 'No Employee') AS employee_name,
    COALESCE(d.department_name, 'No Department') AS department_name
FROM employees AS e
FULL OUTER JOIN departments AS d
    ON e.department_id = d.department_id
ORDER BY department_name, employee_name;
