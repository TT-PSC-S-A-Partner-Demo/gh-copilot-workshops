-- E-commerce Database Setup Script

-- Create the database
CREATE DATABASE EcommerceDB;
GO

USE EcommerceDB;
GO

-- Create Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Phone NVARCHAR(20),
    Address NVARCHAR(200),
    City NVARCHAR(50),
    State NVARCHAR(50),
    ZipCode NVARCHAR(20),
    RegistrationDate DATETIME DEFAULT GETDATE()
);

-- Create Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    CategoryID INT,
    Price DECIMAL(10, 2) NOT NULL,
    StockQuantity INT NOT NULL DEFAULT 0,
    CreatedDate DATETIME DEFAULT GETDATE()
);

-- Create Categories table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(50) NOT NULL,
    Description NVARCHAR(200)
);

-- Add foreign key to Products
ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);

-- Create Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    ShippingAddress NVARCHAR(200),
    ShippingCity NVARCHAR(50),
    ShippingState NVARCHAR(50),
    ShippingZipCode NVARCHAR(20),
    OrderStatus NVARCHAR(20) DEFAULT 'Pending',
    TotalAmount DECIMAL(10, 2) NOT NULL,
    CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID)
    REFERENCES Customers(CustomerID)
);

-- Create OrderItems table
CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    CONSTRAINT FK_OrderItems_Orders FOREIGN KEY (OrderID)
    REFERENCES Orders(OrderID),
    CONSTRAINT FK_OrderItems_Products FOREIGN KEY (ProductID)
    REFERENCES Products(ProductID)
);

-- Insert sample data
-- Categories
INSERT INTO Categories (CategoryName, Description)
VALUES 
    ('Electronics', 'Electronic devices and accessories'),
    ('Clothing', 'Apparel and fashion items'),
    ('Books', 'Books of all genres'),
    ('Home & Kitchen', 'Household items and kitchen appliances');

-- Products
INSERT INTO Products (ProductName, Description, CategoryID, Price, StockQuantity)
VALUES
    ('Smartphone X', 'Latest smartphone with advanced features', 1, 799.99, 100),
    ('Laptop Pro', 'High-performance laptop for professionals', 1, 1299.99, 50),
    ('Wireless Headphones', 'Noise-canceling wireless headphones', 1, 199.99, 150),
    ('T-shirt', 'Cotton T-shirt, various colors', 2, 19.99, 300),
    ('Jeans', 'Denim jeans, regular fit', 2, 49.99, 200),
    ('SQL Programming Guide', 'Comprehensive guide to SQL programming', 3, 39.99, 75),
    ('Coffee Maker', 'Automatic coffee maker with timer', 4, 89.99, 60),
    ('Blender', 'High-speed blender for smoothies', 4, 69.99, 40);

-- Customers
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address, City, State, ZipCode)
VALUES
    ('John', 'Doe', 'john.doe@example.com', '555-123-4567', '123 Main St', 'Boston', 'MA', '02108'),
    ('Jane', 'Smith', 'jane.smith@example.com', '555-987-6543', '456 Oak Ave', 'Seattle', 'WA', '98101'),
    ('Michael', 'Johnson', 'michael.j@example.com', '555-555-5555', '789 Pine Rd', 'Chicago', 'IL', '60601'),
    ('Emma', 'Williams', 'emma.w@example.com', '555-444-3333', '321 Cedar Ln', 'Austin', 'TX', '73301'),
    ('Robert', 'Brown', 'robert.b@example.com', '555-222-1111', '654 Birch Blvd', 'Denver', 'CO', '80202');

-- Orders
INSERT INTO Orders (CustomerID, ShippingAddress, ShippingCity, ShippingState, ShippingZipCode, OrderStatus, TotalAmount)
VALUES
    (1, '123 Main St', 'Boston', 'MA', '02108', 'Delivered', 819.98),
    (2, '456 Oak Ave', 'Seattle', 'WA', '98101', 'Shipped', 1299.99),
    (3, '789 Pine Rd', 'Chicago', 'IL', '60601', 'Processing', 89.98),
    (4, '321 Cedar Ln', 'Austin', 'TX', '73301', 'Pending', 109.98),
    (1, '123 Main St', 'Boston', 'MA', '02108', 'Delivered', 199.99);

-- OrderItems
INSERT INTO OrderItems (OrderID, ProductID, Quantity, UnitPrice)
VALUES
    (1, 1, 1, 799.99),
    (1, 3, 1, 19.99),
    (2, 2, 1, 1299.99),
    (3, 4, 2, 19.99),
    (3, 5, 1, 49.99),
    (4, 7, 1, 89.99),
    (4, 6, 1, 39.99),
    (5, 3, 1, 199.99);
GO
