USE employees;
#Q1 Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not

SELECT CONCAT(first_name, ' ', last_name) AS full_name, dept_no, from_date, to_date,
	IF(to_date > CURDATE(), True, False) AS is_current_employee
FROM dept_emp
JOIN employees AS e USING(emp_no);

#Q2 Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
SELECT CONCAT(first_name, ' ', last_name) AS full_name, 
	CASE 
		WHEN last_name BETWEEN 'a%' AND 'i%' THEN 'A-H'
		WHEN last_name BETWEEN 'i%' AND 'r%' THEN 'I-Q'
		ELSE 'R-Z'
		END AS alpha_group
FROM employees;

#Q3 How many employees (current or previous) were born in each decade?
/*
SELECT birth_date,
	COUNT(CASE WHEN birth_date LIKE '195%' THEN birth_date END) AS 'born_in 1950s',
 	COUNT(CASE WHEN birth_date LIKE '196%' THEN birth_date END) AS 'born_in 1960s',	
	COUNT(CASE WHEN birth_date LIKE '197%' THEN birth_date END) AS 'born_in 1970s'
FROM employees
GROUP BY birth_date;

*/

SELECT COUNT(*) AS total_count,
	CASE 
		WHEN birth_date LIKE '195%' THEN 'Born_in_50s'
		ELSE 'Born_in_1960s'
		END as which_decade
FROM employees
GROUP BY which_decade;
		
#Q4 What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

#First, must group together the departments to create groups

SELECT AVG(salary) AS avg_salary,
   CASE
       WHEN dept_name IN ('research', 'development') THEN 'R&D'
       WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing'
       WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
       ELSE dept_name
   END AS dept_group
FROM departments
JOIN dept_emp AS de USING(dept_no)
JOIN salaries AS s USING(emp_no)
WHERE s.to_date > CURDATE()
GROUP BY dept_group;

