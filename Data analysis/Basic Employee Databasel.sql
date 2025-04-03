CREATE DATABASE Company;
USE Company;
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(255) NOT NULL
);
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY,
    RoleName VARCHAR(255) NOT NULL
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    DepartmentID INT,
    RoleID INT,
    Salary DECIMAL(10, 2),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);

-- Insert data into the Departments table
INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES 
(1, 'Human Resources'),
(2, 'Development'),
(3, 'Marketing');

INSERT INTO Roles (RoleID, RoleName)
VALUES 
(1, 'Manager'),
(2, 'Developer'),
(3, 'HR Specialist'),
(4, 'Marketing Specialist');

INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID, RoleID, Salary)
VALUES 
(1, 'John', 'Doe', 1, 1, 50000.00),
(2, 'Jane', 'Smith', 2, 2, 60000.00),
(3, 'Alice', 'Johnson', 3, 4, 55000.00),
(4, 'Bob', 'Brown', 2, 2, 65000.00),
(5, 'Charlie', 'Davis', 1, 3, 45000.00);
SELECT * FROM Employees;
SELECT e.FirstName, e.LastName, r.RoleName 
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
JOIN Roles r ON e.RoleID = r.RoleID
WHERE d.DepartmentName = 'Development';

SELECT e.FirstName, e.LastName, d.DepartmentName
FROM Employees e
JOIN Roles r ON e.RoleID = r.RoleID
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE r.RoleName = 'Developer';
SET SQL_SAFE_UPDATES = 0;

UPDATE Employees
SET Salary = 70000.00
WHERE FirstName = 'Jane' AND LastName = 'Smith';

DELETE FROM Employees
WHERE FirstName = 'Charlie' AND LastName = 'Davis';

