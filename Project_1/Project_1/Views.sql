USE SkyNet;
Go

-- =======================================================
PRINT 'TABLES DESTRUCTION'
-- =======================================================
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS department;

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
DROP TABLE IF EXISTS new_dept;
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
-- =======================================================
PRINT 'CREATE VIEW'
-- =======================================================
--	Create view from Employee table including columns first_name, last_name, id of the department
DROP view_employee;
CREATE VIEW view_employee
AS SELECT id, first_name, last_name
FROM employee;
GO

SELECT * FROM view_employee

--Create a view of all employees in Department 30. This view will be named View_Dept30 and will contain the columns employee name, employee last name department name, date of employment, salary, and commission for those employees.
CREATE VIEW view_dept_30 (First_Name, Last_Name, Department_Name, Employment_Date, Salary, Commission)
AS SELECT first_name, last_name, id_department, employment_date, salary, commission
FROM employee e
JOIN department d ON e.id_department=d.id
WHERE d.id=30;
GO

SELECT * FROM view_dept_30

--Create a view of all the managers. 
--This view will be named view_manager and will contain the columns of the manager's ID (IDM), name (NameM), salary (SalaryM), and commission (CommM).
CREATE VIEW view_manager (IDM, NameM, LastNameM, SalaryM, CommM)
AS SELECT id, first_name, last_name, salary, commission 
FROM employee
WHERE id IN (SELECT id_manager FROM employee);
GO

SELECT * FROM view_manager;
GO

--Write a statement that uses the view_manager to find the names of the managers who have a salary higher than the average managers salary.
SELECT NameM, LastNameM, SalaryM
FROM view_manager
WHERE SalaryM>(SELECT AVG(SalaryM) FROM view_manager);
GO

--Write a statement that uses the view_dept30 view to find the list of employees in Department 30
--who earn a commission and who have a total income that is lower than the average for employees in the plant.
SELECT First_Name, Last_Name, Salary
FROM view_dept_30
WHERE Commission IS NOT NULL AND
Salary+ISNULL(Commission,0)<(Select AVG(Salary+ISNULL(Commission,0)) FROM view_dept_30);
GO

select AVG(salary+ISNULL(Commission,0)) from view_dept_30


--Write a statement that uses only the view_manager and view_dept_30 views to display the names of the managers, 
--for managers working in department 30.

SELECT NameM, LastNameM
FROM view_manager
WHERE LastNameM IN (SELECT Last_Name from view_dept_30);
GO

--Write a statement that allows you to remove Mr. Rivet from view view_employee.
DELETE FROM view_employee	
WHERE last_name='Rivet';
GO

select * FROM view_employee
select * FROM view_manager
select * FROM view_dept_30

SELECT * FROM department
SELECT * FROM employee
