USE noether_2030;

DROP TABLE IF EXISTS my_numbers;

CREATE TEMPORARY TABLE my_numbers(
	n INT UNSIGNED NOT NULL,
	 name VARCHAR(10) NOT NULL				
);

SELECT *
FROM my_numbers;

#Inserting data into temp table
INSERT INTO my_numbers(n, name)
VALUES (1, 'a'), (2, 'b'), (3, 'c'), (4, 'd'), (5, 'e');

#Deleting from temp table
DELETE FROM my_numbers WHERE n > 4;

#Transform existing WITHOUT data
UPDATE my_numbers SET n = n + 1;

#Transform existing data WITH a conditional statement
UPDATE my_numbers SET n = n + 10
WHERE name = 'a';

SELECT *
FROM my_numbers;

# -------------------------------------------------------------------

#Creating a temp table from another database/schema in a query

USE employees;

SELECT emp_no, dept_no, first_name, last_name, salary, title
FROM employees AS e
JOIN dept_emp AS de USING(emp_no)
JOIN salaries AS s USING(emp_no)
JOIN departments AS d USING(dept_no)
JOIN titles AS t USING(emp_no)
WHERE de.to_date > NOW()
	AND s.to_date > NOW() 
	AND t.to_date > NOW()
	AND dept_name = 'Customer Service';
	
CREATE TEMPORARY TABLE noether_2030.salary_info AS (

SELECT emp_no, dept_no, first_name, last_name, salary, title
FROM employees AS e
JOIN dept_emp AS de USING(emp_no)
JOIN salaries AS s USING(emp_no)
JOIN departments AS d USING(dept_no)
JOIN titles AS t USING(emp_no)
WHERE de.to_date > NOW()
	AND s.to_date > NOW() 
	AND t.to_date > NOW()
	AND dept_name = 'Customer Service'
	
);

SELECT *
FROM noether_2030.salary_info;

#What is the average salary for current employees in Customer Service?
SELECT AVG(salary)
FROM noether_2030.salary_info;

#Add new columns to temp table
ALTER TABLE noether_2030.salary_info ADD avg_salary FLOAT;
ALTER TABLE noether_2030.salary_info ADD std_salary FLOAT;
ALTER TABLE noether_2030.salary_info ADD great_than_avg FLOAT;

SELECT * 
FROM noether_2030.salary_info;

#Update the new columns with new info
UPDATE noether_2030.salary_info SET avg_salary = 67000;

UPDATE noether_2030.salary_info SET std_salary = 16000;

UPDATE noether_2030.salary_info SET great_than_avg = salary > avg_salary;