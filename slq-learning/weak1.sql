CREATE DATABASE my_database;
USE my_database;

CREATE TABLE STAFF
(
STAFF_ID VARCHAR(20),
STAFF_TYPE VARCHAR(30),
SCHOOL_ID VARCHAR(20),
FIRST_NAME VARCHAR(100) NOT NULL,
LAST_NAME VARCHAR(100) NOT NULL,
AGE INT,
DOB DATE,
GENDER VARCHAR(10) CHECK (GENDER IN('M','F')),
JOIN_DATE DATE,
ADRESS_ID VARCHAR(20)
);

-- Insert multiple records at once
INSERT INTO STAFF (STAFF_ID, STAFF_TYPE, SCHOOL_ID, FIRST_NAME, LAST_NAME, AGE, DOB, GENDER, JOIN_DATE, ADRESS_ID)
VALUES 
    ('STF002', 'Teacher', 'SCH001', 'Sarah', 'Johnson', 42, '1982-11-22', 'F', '2018-03-15', 'ADDR002'),
    ('STF003', 'Principal', 'SCH001', 'Robert', 'Williams', 55, '1969-07-30', 'M', '2015-06-01', 'ADDR003'),
    ('STF004', 'Librarian', 'SCH001', 'Emily', 'Davis', 38, '1986-09-10', 'F', '2019-01-20', 'ADDR004'),
    ('STF005', 'Teacher', 'SCH001', 'Michael', 'Brown', 29, '1995-03-18', 'M', '2022-09-01', 'ADDR005'),
    ('STF006', 'Janitor', 'SCH001', 'David', 'Miller', 45, '1979-12-05', 'M', '2017-11-10', 'ADDR006'),
    ('STF007', 'Teacher', 'SCH002', 'Jennifer', 'Wilson', 31, '1993-02-28', 'F', '2021-04-15', 'ADDR007'),
    ('STF008', 'Vice Principal', 'SCH002', 'James', 'Taylor', 48, '1976-08-14', 'M', '2016-07-01', 'ADDR008'),
    ('STF009', 'Teacher', 'SCH002', 'Lisa', 'Anderson', 33, '1991-06-25', 'F', '2020-09-01', 'ADDR009'),
    ('STF010', 'Counselor', 'SCH002', 'Patricia', 'Thomas', 40, '1984-04-12', 'F', '2019-08-15', 'ADDR010');

SELECT * FROM STAFF;


-- REAL START
CREATE DATABASE learning;
USE learning;

-- sys_configEmployeesStaffEmployees📌 PART 1: DDL (Data Definition Language)

-- Ceate tale
CREATE TABLE Employees(
EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
Emain VARCHAR(100) UNIQUE,
Age INT CHECK(Age >= 18),
Salary DECIMAL(10,2),
HireDate DATE,
DepartmentID INT
);

-- ******** Alter Table *******

-- Add a new column
ALTER TABLE Employees 
ADD PhoneNumber VARCHAR(15);

-- Modify coloumn datatype
ALTER TABLE Employees
MODIFY COLUMN Salary DECIMAL(12,2);

-- Rename a column 
ALTER TABLE Employees 
RENAME COLUMN HireDate TO EmploymentDate;

-- Drop a column 
ALTER TABLE Employees
DROP COLUMN PhoneNumber;

-- Add a constraint
ALTER TABLE Employees
ADD CONSTRAINT CHK_Salary CHECK (Salary > 0);

-- Add Foregin Key 
ALTER TABLE Employees
ADD FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID);

-- Rename a Table
ALTER TABLE Employees
RENAME TO Staff;

-- *********** Drop Table ************

-- Delete table
DROP TABLE Employees;

-- Delet if exit 
DROP TABLE IF EXISTS Employees;

-- ********** Truncate Table ********

-- remove all data
TRUNCATE TABLE Employees;

-- vs DELETE (DELETE can have WHERE clause, TRUNCATE cannot)
DELETE FROM Employees; -- Slower, logs individual deletions
TRUNCATE TABLE Employees; -- Faster, resets auto-increment

-- 📌 PART 2: DML (Data Manipulation Language)

-- ********** Insert *******

-- Insert specific columns
INSERT INTO Employees(FirstName, LastName, Age, Salary)
VALUES ('Afaq', 'Ahmad', 22, 50.0);

-- Insert all columns (must match order)
INSERT INTO Employees
VALUES (3, 'Jane', 'Smith', 'jane@email.com', 28, 60000.00, '2023-01-15', 2);

-- Insert Multiple Rows
INSERT INTO Employees (FirstName, LastName, Age, DepartmentID)
VALUES 
	('Mike', 'Johnson', 35, 1),
    ('Sarah', 'Williams', 29, 2),
    ('David', 'Brown', 42, 1);

-- Insert from another table
INSERT INTO Managers (Name, Department, Salary)
SELECT FirstName, 'Sales', Salary * 1.1
FROM Employees
WHERE Age > 30;

-- ********* Update ******

SET SQL_SAFE_UPDATES = 0;

-- Update single column for all rows 
UPDATE Employees 
SET Salary = Salary * 1.05; -- 5% raise for everyone

-- Update with WHERE clause
UPDATE Employees 
SET Salary = 65000, DepartmentID = 3
WHERE EmployeeID = 2;

-- Update with Subquery
UPDATE Employees
SET Salary = (
    SELECT avg_salary FROM (
        SELECT AVG(Salary) AS avg_salary 
        FROM Employees
    ) AS temp
)
WHERE DepartmentID = 1;

-- Use multiple conditions
UPDATE Employees 
SET Salary = Salary * 1.9
WHERE Age > 40 AND DepartmentID = 2;

-- ************* Delete **********

-- Delete specific row
DELETE FROM Employees
WHERE EmployeeID = 101;

-- Delete with multiple coditions
DELETE FROM Employees
WHERE Age < 25 AND Salary < 30000;

-- Delete all rows (use TRUNCATE instead for performance)
DELETE FROM Employees; -- Keeps structure, resets auto-increment in some DBs

-- Delete with JOIN
DELETE e
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'HR';






SELECT * FROM Employees;







