USE employees; 

#Q1 Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.
CREATE TEMPORARY TABLE noether_2030.employees_with_departments AS (
SELECT first_name, last_name, dept_name, to_date
FROM dept_emp
JOIN employees AS e USING(emp_no)
JOIN departments AS d USING(dept_no)
WHERE dept_emp.to_date > CURDATE()
);

SELECT *
FROM noether_2030.employees_with_departments;

DROP TEMPORARY TABLE IF EXISTS noether_2030.employees_with_departments;

DESCRIBE noether_2030.employees_with_departments;

#A Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
ALTER TABLE noether_2030.employees_with_departments ADD full_name VARCHAR(32);

#B Update the table so that full name column contains the correct data
UPDATE noether_2030.employees_with_departments SET full_name = CONCAT(first_name, ' ', last_name);

#C Remove the first_name and last_name columns from the table.
ALTER TABLE noether_2030.employees_with_departments
DROP COLUMN first_name;

ALTER TABLE noether_2030.employees_with_departments
DROP COLUMN last_name;

#D What is another way you could have ended up with this same table?
CREATE TEMPORARY TABLE noether_2030.employees_and_departments AS (
SELECT CONCAT(first_name, ' ', last_name) AS full_name, to_date, dept_name
FROM employees
JOIN dept_emp AS de USING(emp_no)
JOIN departments AS d USING(dept_no)
WHERE de.to_date > CURDATE()
);

SELECT *
FROM noether_2030.employees_and_departments;

#Q2 Create a temporary table based on the payment table from the sakila database.
#Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
CREATE TEMPORARY TABLE noether_2030.payments AS (
SELECT payment_id, customer_id, amount, payment_date
FROM payment
);

SELECT *
FROM noether_2030.payments;

ALTER TABLE noether_2030.payments
DROP COLUMN amount_as_int;

ALTER TABLE noether_2030.payments ADD amount_as_int INT;
UPDATE noether_2030.payments SET amount_as_int = amount * 100.0;

#Q3 Find out how the current average pay in each department compares to the overall current pay for everyone at the company. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?

#Hint Consider that the following code will produce the z score for current salaries.
/* -- Returns the historic z-scores for each salary
-- Notice that there are 2 separate scalar subqueries involved
SELECT salary,
    (salary - (SELECT AVG(salary) FROM salaries))
    /
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries;
*/
									  
CREATE TEMPORARY TABLE noether_2030.salary_info AS (
SELECT DISTINCT dept_name, AVG(salary)
FROM departments AS d
JOIN dept_emp AS de USING(dept_no)
JOIN employees AS e USING(emp_no)
JOIN salaries AS s USING(emp_no)
WHERE s.to_date > CURDATE() AND de.to_date > CURDATE()
GROUP BY dept_name
);

SELECT *
FROM noether_2030.salary_info;

SELECT *
FROM noether_2030.avg_and_std;

CREATE TEMPORARY TABLE noether_2030.avg_and_std AS (
SELECT AVG(salary) AS avg_salary, STD(salary) AS std_salary
FROM salaries
WHERE to_date > CURDATE()
);

DROP TABLE IF EXISTS noether_2030.salary_info;

/* 
CREATE TEMPORARY TABLE noether_2030.dept_avg_sal AS (
SELECT dept_name, AVG(s.salary), zscore
FROM dept_emp
JOIN salaries AS s USING(emp_no)
JOIN (SELECT salary,
    (salary - (SELECT AVG(salary) FROM salaries))
    /
    (SELECT stddev(salary) FROM salaries) AS zscore
    FROM salaries) AS z USING(salary) 
JOIN departments AS d USING(dept_no)
WHERE dept_emp.to_date > CURDATE()
GROUP BY dept_name, zscore
);
*/

-- Adam's example solution

#Equation for zscore
SELECT salary,
    (salary - (SELECT AVG(salary) FROM salaries))
    /
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries;

#Creating table with avg and std
CREATE TEMPORARY TABLE noether_2030.overall_agg AS (
	SELECT AVG(salary) AS avg_salary, STD(salary) AS std_salary
	 FROM employees.salaries
	 WHERE to_date > NOW()
);

#Checking values
SELECT *
FROM noether_2030.overall_agg;

#Average salary by dept
CREATE TEMPORARY TABLE noether_2030.metrics AS (
	SELECT dept_name, AVG(salary) AS dept_average
	FROM employees.salaries
	JOIN employees.dept_emp USING(emp_no)
	JOIN employees.departments USING(dept_no)
	WHERE employees.dept_emp.to_date > NOW()
	AND employees.salaries.to_date > NOW()
	GROUP BY dept_name
);

SELECT *
FROM noether_2030.metrics;

#Create columns for table
ALTER TABLE noether_2030.metrics ADD overall_avg FLOAT (10, 2);
ALTER TABLE noether_2030.metrics ADD overall_std FLOAT (10, 2);
ALTER TABLE noether_2030.metrics ADD dept_zscore FLOAT (10, 2);

#Update table with avg
UPDATE noether_2030.metrics SET overall_avg = (SELECT avg_salary FROM noether_2030.overall_agg);

#Update table with std
UPDATE noether_2030.metrics SET overall_std = (SELECT std_salary FROM noether_2030.overall_agg);

#Update with zscore
UPDATE noether_2030.metrics SET dept_zscore = (SELECT dept_average - overall_avg) / overall_std;

#Final check
SELECT *
FROM noether_2030.metrics;
#BONUS To your work with current salary zscores, determine the overall historic average departement average salary, the historic overall average, and the historic zscores for salary. Do the zscores for current department average salaries tell a similar or a different story than the historic department salary zscores?