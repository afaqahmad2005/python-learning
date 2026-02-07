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
