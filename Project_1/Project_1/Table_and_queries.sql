CREATE DATABASE SkyNet;
Go

USE SkyNet;
Go

-- =======================================================
PRINT 'TABLES DESTRUCTION'
-- =======================================================
DROP TABLE employee;
DROP TABLE department;

-- =======================================================
PRINT 'TABLES CREATION'
-- =======================================================
CREATE TABLE department (
	id INT,
	title VARCHAR (30),
	city VARCHAR(30),
	CONSTRAINT pk_dept PRIMARY KEY (id)
);

CREATE TABLE employee (
	id				INT,
	id_department	INT,
	id_manager		INT,
	first_name		VARCHAR (30),
	last_name		VARCHAR (30),
	position		VARCHAR (30),
	employment_date DATE,
	salary			MONEY,
	commission		MONEY,
	CONSTRAINT pk_emp PRIMARY KEY (id),
	CONSTRAINT fk_emp_dept FOREIGN KEY (id_department) REFERENCES department (id),
	CONSTRAINT fk_emp_manager FOREIGN KEY (id_manager) REFERENCES employee(id)
);
-- =======================================================
-- Configuration of the format DATE (DAY/MONTH/YEAR)
-- =======================================================
SET DATEFORMAT DMY
GO

-- =======================================================
PRINT 'INSERTING RECORDS INTO TABLES'
-- =======================================================
INSERT INTO department VALUES
(10, 'accounting',	'Montreal'),
(20, 'research',	'Ottawa'),
(30, 'sales',		'Vancouver'),
(40, 'operations',	'Calgary');
GO

INSERT INTO employee VALUES
(6600,	null,null,	'Sabrina',	'Roy',		'president',				 '17/11/1981',	5000,	null),
(7700,	10,	6600,	'Annie',	'Cabana',	'manager',					 '09/06/1981',	2450,	null),
(7783,	10,	7700,	'Bruno',	'Belanger',	'senior accountant',		 '19/06/1993',	2000,	null),
(7784,	10,	7700,	'Alexij',	'Kowal',	'accountant',			 	 '05/12/1991',	1500,	null),
(7785,	10,	7700,	'Noemi',	'Parent',	'clerk',					 '23/01/1982',	1300,	null),
(8700,	20,	6600,	'Tina',		'Joly',		'manager',					 '02/04/1981',	2975,	null),
(8783,	20,	8700,	'Tony',		'Adam',		'clerk',				 	 '11/07/1987',	1100,	null),
(8784,	20,	8700,	'Boris',	'Rivet',	'clerk',					 '17/12/1980',	800,	null),
(8785,	20,	8700,	'Sylvie',	'Bergeron',	'analyst',					 '07/06/1987',	3000,	null),
(8786,	20,	8700,	'Adam',		'Fontaine',	'analyst',					 '03/05/1981',	3000,	null),
(9700,	30,	6600,	'Adam',		'Bourque',	'manager',					 '01/09/1981',	2850,	null),
(9783,	30,	9700,	'Bruno',	'Paquette',	'sales associate',			 '08/09/1981',	1500,	550),
(9784,	30,	9700,	'Noemie',	'Demers',	'sales associate',			 '20/02/1981',	1600,	600),
(9785,	30,	9700,	'Justin',	'Tremblay',	'sales associate',			 '22/02/1981',  1250,	500),
(9786,	30,	9700,	'Amalia',	'Martin',	'sales associate',			 '28/09/1981',	1250,	500),
(9787,	30,	9700,	'Edouard',	'Genereux',	'clerk',					 '03/12/1981',	950,	null),
(10787,	40,	6600,	'Justin',	'Simon',	'production manager',		 '02/03/1980',	3000,	null),
(10788,	40,	10787,	'Edouard',	'Levesque', 'project manager',			 '06/03/1990',	2000,	null),
(10789,	40,	10787,	'Tony',		'Gobin',	'assistant project manager', '02/04/1989',	1700,	null),
(10790,	40,	10788,	'Amalia',	'Laroche',	'operations analyst',		 '24/03/1992',	1500,	null),
(10800,	null, null,	'Justin',	'Abraham',	'trainee',					 '06/06/1999',	1800,	null),
(10801,	null, null,	'Monika',	'Roger',	'trainee',					 '27/10/1996',	1800,	null),
(10802, null, null,	'Hugo',		'Clarks',	'trainee',					 '18/05/1999',	1200,	null),
(10803, null, null,	'Simon',	'Berger',	'trainee',					 '08/11/1999',	1200,	null);
GO

SELECT * FROM department
SELECT * FROM employee

-- =======================================================
PRINT 'CREATING A TABLE new_dept'
-- =======================================================
DROP TABLE new_dept;
CREATE TABLE new_dept(
	id  	INT,
    title   VARCHAR(15),
    city	VARCHAR(20));
GO

-- =======================================================
PRINT 'INSERTING RECORDS INTO TABLES new_dept'
-- =======================================================
INSERT INTO new_dept VALUES	(15,'Marketing','Toronto');
INSERT INTO new_dept VALUES	(25,'HR','Charlottetown');
INSERT INTO new_dept VALUES	(50,'Real Estate','Edmonton');
INSERT INTO new_dept VALUES	(60,'PR','StJean');
GO

SELECT * FROM new_dept

USE SkyNet;
GO

INSERT INTO department 
SELECT * FROM new_dept
GO

SELECT * FROM department
-- =======================================================
PRINT 'QUERY 1. AVERAGE SALARY'
SELECT AVG(salary) FROM employee;
GO

PRINT 'QUERY 2. AVERAGE SALARY BY DEPARTMENT'
SELECT id_department, avg(salary) FROM employee
GROUP BY id_department;
GO

PRINT 'QUERY 3. AVERAGE SALARY FOR DEPARTMENT WITH MORE THAN 4 EMPLOYEES'
SELECT id_department, AVG(salary) FROM employee
GROUP BY id_department
HAVING COUNT(*)>4;
GO

PRINT 'QUERY 4. AVERAGE SALARY BY DEPARTMENT WHERE MAXIMUM SALARY IS 3000'
SELECT id_department, AVG(salary) FROM employee
GROUP BY id_department
HAVING MAX(salary)=3000;
GO

PRINT 'QUERY 5. AVERAGE SALARY OF THE CLERK'
SELECT AVG(salary) 'Av. salary-clerk' FROM employee
WHERE position='clerk';
GO

PRINT 'QUERY 6. AVERAGE SALARY OF THE CLERK BY DEPARTMENT IN DESCENDING ORDER'
SELECT id_department, AVG(salary) FROM employee
WHERE position='clerk'
GROUP BY id_department
ORDER BY AVG(salary) DESC;
GO

PRINT 'QUERY 7. FOR EACH EMPLOYEE DISPLAY THEIR lAST NAME, EMPLOYEE NUMBER AND THE CITY IN WHICH THEY WORK'
SELECT e.first_name, e.last_name,  e.id, d.city
FROM employee AS e, department AS d
WHERE d.id=e.id_department;
GO

PRINT 'QUERY 8. TO QUERY 7 ADD EMPLOYEES WHO DO NOT BELONG TO PARTICULAR CITY'
SELECT e.first_name, e.last_name, e.id, d.city
FROM employee e LEFT JOIN department d ON e.id_department = d.id;
GO

PRINT 'QUERY 9. TO QUERY 7 ADD THE RESULTS NOT ONLY EMPLOYEES WHO DO NOT BELONG TO ANY DEPARTMENT, BUT DEPARTMENTS THAT HAVE NO EMPLOYEES.'
SELECT e.first_name, e.last_name, e.id, d.city
FROM employee e FULL JOIN department d ON e.id_department = d.id;
GO

PRINT 'QUERY 10. LIST OF EMPLOYEES WHO WORK IN A CITY OTHER THAN MONTREAL.'
PRINT 'INCLUDE THE EMPLOYEE LAST NAME AND CITY NAME IN THE RESPONSE. DISPLAY IN ORDER OF EMPLOYEE NAME.'
SELECT e.first_name, e.last_name, d.city
FROM employee e, department d
where e.id_department=d.id AND d.city!='Montreal'
ORDER BY e.last_name;
GO

PRINT 'QUERY 11. LIST OF EMPLOYEES WHO DO NOT BELONG TO ANY DEPARTMENT.' 
PRINT 'INCLUDE THE EMPLOYEE LAST NAME AND CITY NAME IN THE RESPONSE.'
SELECT e.first_name, e.last_name, d.city
FROM employee e LEFT JOIN department d ON e.id_department = d.id
WHERE city != 'Montreal' OR city IS NULL
ORDER BY e.last_name;
GO

PRINT 'QUERY 12. FOR QUERY 11 ADD THE CITIES WHERE THERE ARE THE DEPARTMENTS WITH NO EMPLOYEES ARE LOCATED.'
SELECT e.first_name, e.last_name, d.city
FROM employee e FULL JOIN department d ON e.id_department = d.id
WHERE city != 'Montreal' OR city IS NULL
ORDER BY e.last_name;
GO

PRINT 'QUERY 13. VIEW A LIST OF EMPLOYEES WITH THEIR MANAGER AND DEPARTMENT NAME.'
--STEP 1. EMPLOYEE WITH THEIR DEPARTMENTS
SELECT e.first_name 'E.Name', e.last_name 'E.Last Name', d.title 'E.Dept'
FROM employee e LEFT JOIN department d ON e.id_department=d.id;
GO
--STEP 2. ADD MANAGER
SELECT e.first_name 'E.Name', e.last_name 'E.Last Name', d.title 'E.Dept',  e2.first_name 'M.Name', e2.last_name 'M.Last Name'
FROM employee e LEFT JOIN department d ON e.id_department=d.id 
LEFT JOIN employee e2 ON e.id_manager=e2.id;
GO
--STEP 3. LINK MANAGER WITH RELEVANT DEPARTMENT
SELECT  e.first_name 'E.Name', e.last_name 'E.Last Name', d.title 'E.Dept', e2.first_name 'M.Name', e2.last_name 'M.Last Name', d2.title 'M.Dept'
FROM employee e LEFT JOIN department d ON e.id_department=d.id 
LEFT JOIN employee e2 ON e.id_manager=e2.id
LEFT JOIN department d2 ON d.title=d2.title;
GO

PRINT 'QUERY 14. PAIRS OF <EMPLOYEE,EMPLOYEE> VALUES ??SO THAT THE SECOND EMPLOYEE EARNS A HIGHER SALARY THAN THE FIRST'
PRINT 'FOR EACH EMPLOYEE, PROVIDE THE NAME AND SALARY.'
SELECT e.last_name, e.salary, e1.last_name, e1.salary
FROM employee e, employee e1
WHERE e.salary < e1.salary;
GO

PRINT 'QUERY 15. ADD THE FOLLOWING EMPLOYEE TO THE EMPLOYEE TABLE: HUGO DEMERS, ID 1234, DEPARTMENT 20, MANAGER ID: 6600'
INSERT INTO employee VALUES (1234, 20, 6600, 'Hugo','Demers', NULL, NULL, NULL, NULL);
GO

PRINT 'QUERY 16. DEPARTMENTS THAT HAVE AN EMPLOYEE WHO HAS THE SAME NAME AS AN EMPLOYEE IN ANOTHER DEPARTMENT'
--STEP 1. SELECT EMPLOYEE WITH DEPARTMENT
select e.first_name, e.last_name, e.id, d.id
from employee e, department d
LEFT JOIN employee e2 ON e.id_department=e2.id_department
AND e.last_name!=e2.last_name
AND d.id!=d2.id

--STEP 2. SELECT EMPLOYEES WITH SAME NAME AND DEPARTMENT
SELECT e.first_name, e.last_name, e2.first_name, e2.last_name
FROM employee e, department d, employee e2
WHERE e.id_department=d.id AND 
	  e.first_name=e2.first_name

--STEP 3. FIND A DEPARTMENT OF THE SECOND EMPLOYEE
SELECT e.last_name, e.id, d.id, e2.last_name, e2.id, d2.id
FROM
	employee e, department d,
	employee e2, department d2
WHERE 
	e.id_department=d.id AND
	e2.id_department=d2.id AND
	e.last_name=e2.last_name AND
	d.id!=d2.id
