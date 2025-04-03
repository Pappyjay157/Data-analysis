CREATE DATABASE SalesDB;
USE SalesDB;
CREATE TABLE Customers(
	CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    City VARCHAR(50)
);
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10 , 2 ) NOT NULL,
    StockQuantity INT NOT NULL
);
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Position VARCHAR(50),
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    Subtotal DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
INSERT INTO Customers (FirstName, LastName, Email, Phone, City) VALUES
('John', 'Doe', 'john.doe@email.com', '1234567890', 'New York'),
('Alice', 'Smith', 'alice.smith@email.com', '9876543210', 'Los Angeles'),
('Bob', 'Brown', 'bob.brown@email.com', '5556667777', 'Chicago');

INSERT INTO Products (ProductName, Category, Price, StockQuantity) VALUES
('Laptop', 'Electronics', 800.00, 10),
('Smartphone', 'Electronics', 500.00, 20),
('Headphones', 'Accessories', 100.00, 50),
('Office Chair', 'Furniture', 150.00, 5);
INSERT INTO Orders (CustomerID, TotalAmount) VALUES
(1, 1300.00), -- John Doe's order
(2, 500.00),  -- Alice Smith's order
(3, 250.00);  -- Bob Brown's order

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Subtotal) VALUES
(1, 1, 1, 800.00), -- John bought a laptop
(1, 3, 5, 500.00), -- John also bought 5 headphones
(2, 2, 1, 500.00), -- Alice bought a smartphone
(3, 4, 1, 250.00); -- Bob bought an office chair
SELECT * FROM Customers;
SELECT Orders.OrderID, Customers.FirstName, Customers.LastName, Orders.OrderDate, Orders.TotalAmount
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID;
SELECT OrderDetails.OrderID, Products.ProductName, OrderDetails.Quantity, OrderDetails.Subtotal
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID;

SELECT Products.ProductName, SUM(OrderDetails.Quantity) AS TotalSold
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.ProductName
ORDER BY TotalSold DESC
LIMIT 1;

SELECT Customers.FirstName, Customers.LastName, SUM(Orders.TotalAmount) AS TotalSpent
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Customers.CustomerID
ORDER BY TotalSpent DESC;

ALTER TABLE Orders ADD COLUMN EmployeeID INT;
ALTER TABLE Orders ADD FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID);
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    PaymentMethod VARCHAR(50) CHECK (PaymentMethod IN ('Cash', 'Credit Card', 'PayPal', 'Bank Transfer')),
    PaymentDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    AmountPaid DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY AUTO_INCREMENT,
    SupplierName VARCHAR(100) NOT NULL,
    ContactName VARCHAR(100),
    Phone VARCHAR(20),
    City VARCHAR(50)
);
ALTER TABLE Products ADD COLUMN SupplierID INT;
ALTER TABLE Products ADD FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID);

ALTER TABLE OrderDetails ADD COLUMN Discount DECIMAL(5,2) DEFAULT 0;
ALTER TABLE OrderDetails ADD COLUMN Tax DECIMAL(5,2) DEFAULT 5.00;

SELECT ProductName, StockQuantity
FROM Products
WHERE StockQuantity < 10;
SELECT Customers.FirstName, Customers.LastName, Products.ProductName, OrderDetails.Quantity, Orders.OrderDate
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
WHERE Customers.CustomerID = 2;  

SELECT Products.ProductName, SUM(OrderDetails.Quantity) AS TotalSold
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.ProductName
ORDER BY TotalSold DESC
LIMIT 5;

SELECT Customers.FirstName, Customers.LastName, SUM(Orders.TotalAmount) AS TotalSpent
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Customers.CustomerID
ORDER BY TotalSpent DESC
LIMIT 5;
SELECT YEAR(OrderDate) AS Year, MONTH(OrderDate) AS Month, SUM(TotalAmount) AS TotalSales
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY Year DESC, Month DESC;
