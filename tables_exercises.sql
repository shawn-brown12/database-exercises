SHOW DATABASES;

USE employees;

SHOW TABLES;

SELECT * FROM employees;

SHOW CREATE TABLE employees;

/* Which table(s) do you think contain a numeric type column? I think all of them would have a numeric value of some sort, and they all do, except for the departmsnts table.

Which table(s) do you think contain a string type column? Again, I would think all of the tables have at least one string type column.

Which table(s) do you think contain a date type column? I think most of them would have a date column somewhere within the tables; all of them except for the departments table.

What is the relationship between the employees and the departments tables? There is no relationship between those two tables. */

SHOW CREATE TABLE dept_manager;