-- Create Database
CREATE DATABASE StudentDB;

-- Use Database
USE StudentDB;

-- Create Table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Age INT,
    Department VARCHAR(100)
);

-- Insert Data
INSERT INTO Students (FirstName, LastName, Age, Department)
VALUES
('Atia', 'Sanjida', 22, 'Information & Communication Engineering'),
('Rahim', 'Ahmed', 21, 'Computer Science'),
('Karim', 'Hasan', 23, 'Electrical Engineering');

-- Display All Data
SELECT * FROM Students;

-- Display Specific Columns
SELECT FirstName, Department
FROM Students;

-- Filter Data
SELECT *
FROM Students
WHERE Age > 21;

-- Update Data
UPDATE Students
SET Department = 'Cyber Security'
WHERE StudentID = 1;

-- Delete a Record
DELETE FROM Students
WHERE StudentID = 3;

-- Display Data After Update/Delete
SELECT * FROM Students;

-- Drop Table (Optional)
-- DROP TABLE Students;

-- Drop Database (Optional)
-- DROP DATABASE StudentDB;