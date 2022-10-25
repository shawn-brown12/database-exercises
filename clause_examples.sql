USE employees;

#To find those born after 1990-01-01

SELECT * 
FROM employees
WHERE hire_date >= '1990-01-01';

DESCRIBE employees;

#To find those hired in the 1990's

SELECT *
FROM employees
WHERE hire_date LIKE '199%';

#To find those born in October

SELECT *
FROM employees
WHERE hire_date LIKE '%-10-%';

#To find those not born in October

SELECT *
FROM employees
WHERE hire_date NOT LIKE '%-10-%';

#To find those hired between 1990 and 1999

SELECT *
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';

#To find those whose first name starts with S

SELECT *
FROM employees
WHERE first_name LIKE 's%';

#To find those whose first name starts and ends with S

SELECT *
FROM employees
WHERE first_name LIKE 's%s';

#To find those whose first and last names start with S

SELECT *
FROM employees
WHERE first_name LIKE 's%' AND last_name LIKE 's%';

#To find those whose first name OR last name starts with S

SELECT * 
FROM employees
WHERE first_name LIKE 's%' OR last_name LIKE 's%';

#To find all records where last name is either 'Foote' or 'Sidou'

SELECT *
FROM employees
WHERE last_name = 'Foote' OR last_name = 'Sidou';

#OR 

SELECT *
FROM employees
WHERE last_name IN ('Foote', 'Sidou');

#To find if any hire_dates are null

SELECT *
FROM employees
WHERE hire_date IS NULL;

#To find if any hire_dates are not null

SELECT *
FROM employees
WHERE hire_date IS NOT NULL;

#Find employees who were hired in the 90s AND first_name starts with S or last_name starts with S

SELECT *
FROM employees
Where hire_date BETWEEN '1990-01-01' AND '1999-12-31'
	AND (first_name LIKE 's%' OR last_name LIKE 's%');
	
# Emlpoyees hired in the 90s, ORDER BY ASCENDING; ORDER BY defaults to ASC

SELECT *
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
ORDER BY hire_date ASC;	

# Emlpoyees hired in the 90s, ORDER BY DESCENDING; ORDER BY defaults to ASC

SELECT *
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
ORDER BY hire_date DESC;

#Sort by gender and hire_date

SELECT *
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
ORDER BY hire_date ASC, gender DESC;

#Adding a LIMIT limits the number of rows returned

#Finding the oldest employees hired in 1990
SELECT *
FROM employees
WHERE hire_date LIKE '1990%'
ORDER BY birth_date ASC, first_name ASC
LIMIT 5;

#Offset LIMIT; OFFSET skips %

SELECT *
FROM employees
WHERE hire_date LIKE '1990%'
ORDER BY birth_date ASC, first_name ASC
LIMIT 5 OFFSET 3;

