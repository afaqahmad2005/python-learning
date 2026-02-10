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


-- 📌 PART 3: DQL (Data Query Language)

-- ************ Select *************
-- Select all comunms
SELECT * FROM Employees;

-- Select specific columns 
SELECT FirstName, LastName, Salary FROM Employees;

-- Select with expressions 
SELECT FirstName, LastName, Salary, Salary * 0.10 AS Bonus, Salary * 12 AS AnualSalary FROM Employees;

-- ************ Distinct ************
-- Unique Departments
SELECT DISTINCT DepartmentID FROM Employees;

-- Unique Combinations
SELECT DISTINCT FirstName, LastName FROM Employees;

-- Count Unique Values
SELECT COUNT(DISTINCT DepartmentID) AS UniqueDepartments FROM Employees;

-- *********** Where **********
-- Basic Conditions
SELECT * FROM Employees
WHERE Age > 30;

-- Multiple Conditions
SELECT * FROM Employees 
WHERE DepartmentID = 2 AND Salary > 0;

-- Text Matching
SELECT * FROM Employees
WHERE LastName = 'Ahmad';

-- Not Condition
SELECT * FROM Employees
WHERE NOT DepartmentID = 3;

-- ************ Like and WildCard
-- Starts with J
SELECT * FROM Employees
WHERE FirstName LIKE 'A%';

-- Ends with 'mad'
SELECT * FROM Employees
WHERE LastName LIKE '%mad';

-- Conains 'f'
SELECT * FROM Employees
WHERE FirstName LIKE '%f%';

-- Second letter is 'o'
SELECT * FROM Employees 
WHERE FirstName LIKE '_o%';

-- Exactly 4 characters
SELECT * FROM Employees
WHERE FirstName LIKE '____';

-- *********** IN & BETWEEN **************
-- IN: Match list of values
SELECT * FROM Employees 
WHERE DepartmentID IN (1,2,5);

-- IN with subquery
SELECT * FROM Employees
WHERE DepartmentID IN (
    SELECT DepartmentID 
    FROM Departments 
    WHERE Location = 'New York'
);

-- BETWEEN: Range (inclusive)
SELECT * FROM Employees
WHERE Salary BETWEEN 40000 AND 60000;

SELECT * FROM Employees
WHERE HireDate BETWEEN '2023-01-01' AND '2023-12-31';

-- NOT BETWEEN
SELECT * FROM Employees
WHERE Age NOT BETWEEN 25 AND 40;


-- *********** AND, OR, NOT ************

-- AND (Both conditions must be true)
SELECT * FROM Employees 
WHERE Age > 20 AND Salary > 50000;

-- OR (At least one condition is true)
SELECT * FROM Employees 
WHERE DepartmentID = 1 OR DepartmentID = 3;

-- Combination with parentheses 
SELECT * FROM Employees 
WHERE (Age > 20 AND Salary > 50000) OR (DepartmentID = 2);

-- NOT with other operators 
SELECT * FROM Employees
WHERE NOT (Age < 25 OR Salary < 30000);

-- Complex Example 
SELECT * FROM Employees 
WHERE (FirstName LIKE 'A%' OR FirstName LIKE 'S%')
	AND Age BETWEEN 25 AND 45
    AND NOT DepartmentID = 1;

-- ********* Order By **********

-- Ascending (default)
SELECT * FROM Employees 
ORDER BY LastName;

-- Descinding 
SELECT * FROM Employees
ORDER BY Salary DESC;

-- Multiple columns
SELECT * FROM Employees
ORDER BY DepartmentID ASC, LastName ASC, FirstName ASC;

-- Order By column number
SELECT FirstName, LastName, Salary FROM Employees
ORDER BY 3 DESC; -- (Salary)

-- Order By expressions
SELECT FirstName, LastName, Salary FROM Employees
ORDER BY Salary * 12 DESC; -- Annual Salary

-- ********** LIMIT / TOP ************

-- MySQL: LIMIT
SELECT * FROM Employees
ORDER BY Salary DESC
LIMIT 5; -- Top 5 highest paid

-- With offset (skip first N rows)
SELECT * FROM Employees
ORDER BY HireDate
LIMIT 10 OFFSET 5; -- Rows 6-15

-- Alternative syntax
SELECT * FROM Employees
LIMIT 5, 10; -- Skip 5, take 10

-- ************* 📌 PART 4: Data Types ***********

CREATE TABLE DataTypesDemo (
    -- Numeric Types
    ID INT PRIMARY KEY AUTO_INCREMENT,           -- Whole numbers
    Age TINYINT,                                  -- -128 to 127
    Price DECIMAL(10, 2),                         -- Fixed precision (10 digits, 2 decimal)
    Salary FLOAT,                                 -- Approximate numbers
    Rating DOUBLE(5,2),                           -- Double precision
    
    -- String Types
    FirstName VARCHAR(50),                        -- Variable length string
    LastName CHAR(50),                            -- Fixed length string
    Email VARCHAR(100) UNIQUE,
    Description TEXT,                             -- Large text
    Bio LONGTEXT,                                 -- Very large text
    
    -- Date/Time Types
    BirthDate DATE,                               -- YYYY-MM-DD
    HireDateTime DATETIME,                        -- YYYY-MM-DD HH:MM:SS
    LastLogin TIMESTAMP,                          -- Auto-updating timestamp
    MeetingTime TIME,                             -- HH:MM:SS
    YearOnly YEAR,                                -- YYYY
    
    -- Binary Types
    ProfilePicture BLOB,                          -- Binary Large Object
    Document LONGBLOB,
    
    -- Boolean (MySQL uses TINYINT(1))
    IsActive BOOLEAN,                             -- TRUE or FALSE
    IsManager TINYINT(1) DEFAULT 0,
    
    -- Other
    JSONData JSON,                                -- JSON formatted data
    ENUMField ENUM('Active', 'Inactive', 'Pending'),
    SETField SET('Read', 'Write', 'Execute')
);

-- 📊 PART 1: Aggregate Functions

-- *************** 1. COUNT() *************

-- Count all rows 
SELECT COUNT(*) AS TotalEmployees FROM Employees;

-- Count NOT NULL values in a column
SELECT COUNT(DepartmentID) AS EmployeesWithDept FROM Employees;

-- Count DISTICT values 
SELECT COUNT(DISTINCT DepartmentID) AS UniqueDepartment FROM Employees;

-- Count with conditions
SELECT COUNT(*) AS HighEarners FROM Employees
WHERE Salary > 50000;

-- **************** 2. SUM() ***************

-- Total Salary Expenditure 
SELECT SUM(Salary) AS TotalSalaryCost FROM Employees;

-- SUM with codition
SELECT SUM(Salary) AS SalesDeptSalary 
FROM Employees
WHERE DepartmentID = 2;

-- SUM DISTINCT values (rarely used)
SELECT SUM(DISTINCT Salary) AS SumOfUniqueSalaries FROM Employees;

-- ******************** 3. AVG() ********************

-- Average Salary 
SELECT AVG(Salary) AS AvgSalary
FROM Employees;

-- Average with ROUND
SELECT ROUND(AVG(Salary),2) 
AS AvgSalaryRounded 
FROM Employees;

-- Average with condition
SELECT AVG(Age) AS AvgAgeSales
FROM Employees
WHERE DepartmentID = 1; 

-- Handle NULL values (NULLs are ignored in AVG)
SELECT AVG(coalesce(Salary,0)) AS AvgWithNulls FROM Employees;

-- ***************** 4. MIN() & MAX() ********************

-- Minimum and Maximum Salary
SELECT 
	MIN(Salary) AS LowestSalary,
    MAX(Salary) AS HighestSalary
FROM Employees;

-- Find oldest and youngest Employees
SELECT
	MIN(Age) AS YoungestAge,
    MAX(Age) AS OldestAge
FROM Employees;

-- First and Last Hire Date 
SELECT
	MIN(HireDate) AS FistHire,
    MAX(HireDate) AS LastHire
FROM Employees;

-- Minimum with condition
SELECT MIN(Salary) AS MinSalaryInSale
FROM Employees 
WHERE DepartmentID = 1;

-- *************** 5. Using Multiple Aggregate Functions ***************
SELECT 
	COUNT(*) AS TotalEmployees,
    AVG(Salary) AS AverageSalary,
    MIN(Salary) AS MinumumSalary,
    MAX(Salary) AS MaximumSalary,
    SUM(Salary) AS TotalSalaryCost,
    MAX(HireDate) AS LatestHireDate
FROM Employees;

-- 📊 PART 2: GROUP BY

-- ***************** Basic GROUP BY ******************

-- Count Employees per department
SELECT DepartmentID, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentID;
    
-- Average Salary per Department 
SELECT 
	DepartmentID, 
    ROUND(AVG(Salary),2) AS AvgSalary
FROM Employees
GROUP BY DepartmentID
ORDER BY AvgSalary DESC;

-- Multiple grouping columns
SELECT
	DepartmentID,
    Age,
    COUNT(*) AS Count,
    AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentID, Age
ORDER BY DepartmentID, Age;

-- ****************** GROUP BY with WHERE ***********************

-- Average salary per department for employees hired after 2020
SELECT 
    DepartmentID,
    AVG(Salary) AS AvgSalary
FROM Employees
WHERE HireDate >= '2020-01-01'
GROUP BY DepartmentID;

-- Count employees by gender in Sales department
SELECT 
	Age,
    COUNT(*) AS EmployeeCount
FROM Employees
WHERE DepartmentID = 1
GROUP BY Age;

-- **************** GROUP BY with Expressions ********************

-- Group by age ranges 
SELECT 
	CASE
		WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 35 THEN '25-35'
        WHEN Age BETWEEN 35 AND 45 THEN '35-45'
        ELSE 'Over 45'
	END AS AgeGroup,
    COUNT(*) AS EmployeeCount,
    AVG(Salary) AS AvgSalary 
FROM Employees
GROUP BY 
    CASE
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 35 THEN '25-35'
        WHEN Age BETWEEN 35 AND 45 THEN '35-45'
        ELSE 'Over 45'
    END
ORDER BY AgeGroup;

-- Group by year of hire
SELECT 
    YEAR(HireDate) AS HireYear,
    COUNT(*) AS HiresCount
FROM Employees
GROUP BY YEAR(HireDate)
ORDER BY HireYear;


-- 📊 PART 3: HAVING

-- Departments with more than 5 employees
SELECT 
	DepartmentID,
    COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentID
HAVING COUNT(*) < 5;

-- Departments with average salary > 5
SELECT
	DepartmentID,
    AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentID
HAVING AVG(Salary) > 5000
ORDER BY AvgSalary DESC;

-- Using multiple conditions in having 
SELECT
	DepartmentID,
    Age,
    COUNT(*) AS Count,
    AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentID, Age
HAVING COUNT(*) <= 30 AND AVG(Salary) > 4000
ORDER BY DepartmentID;

-- Departments where total salary > 50000
SELECT 
	DepartmentID,
    SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY DepartmentID
HAVING SUM(Salary) > 50000;

-- Complex HAVING with WHERE
SELECT 
    DepartmentID,
    COUNT(*) AS Count,
    AVG(Salary) AS AvgSalary
FROM Employees
WHERE HireDate >= '2020-01-01'  -- Filter rows first
GROUP BY DepartmentID
HAVING AVG(Salary) > 45000      -- Then filter groups
ORDER BY AvgSalary DESC;






