SHOW DATABASES;

USE employees;

SHOW TABLES;

SELECT * FROM employees;

DESCRIBE employees;

/* Which table(s) do you think contain a numeric type column? I think all of them would have a numeric value of some sort, and they all do, except for the departments table.

Which table(s) do you think contain a string type column? Again, I would think all of the tables have at least one string type column.

Which table(s) do you think contain a date type column? I think most of them would have a date column somewhere within the tables; all of them except for the departments table.

What is the relationship between the employees and the departments tables? There is no relationship between those two tables. */

SHOW CREATE TABLE dept_manager;

/* 
CREATE TABLE `dept_manager` (
  `emp_no` int NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1

*/
