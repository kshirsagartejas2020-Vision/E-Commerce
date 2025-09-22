-- Create Database
CREATE DATABASE EcommerceDB;
GO

USE EcommerceDB;
GO

-- Customers Table
CREATE TABLE Customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50),
    email NVARCHAR(100) UNIQUE NOT NULL,
    phone NVARCHAR(20),
    address NVARCHAR(255),
    city NVARCHAR(50),
    state NVARCHAR(50),
    postal_code NVARCHAR(20),
    created_at DATETIME DEFAULT GETDATE()
);

-- Categories Table
CREATE TABLE Categories (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    category_name NVARCHAR(100) NOT NULL,
    description NVARCHAR(MAX)
);

-- Products Table
CREATE TABLE Products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    product_name NVARCHAR(100) NOT NULL,
    description NVARCHAR(MAX),
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    category_id INT,
    created_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Products_Categories FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Orders Table
CREATE TABLE Orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    order_date DATETIME DEFAULT GETDATE(),
    status NVARCHAR(20) DEFAULT 'Pending' CHECK (status IN ('Pending','Shipped','Delivered','Cancelled')),
    total_amount DECIMAL(10,2),
    CONSTRAINT FK_Orders_Customers FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Order Items Table (Many-to-Many between Orders & Products)
CREATE TABLE OrderItems (
    order_item_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_OrderItems_Orders FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    CONSTRAINT FK_OrderItems_Products FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Payments Table
CREATE TABLE Payments (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT,
    payment_date DATETIME DEFAULT GETDATE(),
    amount DECIMAL(10,2) NOT NULL,
    method NVARCHAR(20) CHECK (method IN ('Credit Card','Debit Card','UPI','Net Banking','COD')),
    CONSTRAINT FK_Payments_Orders FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE
);

-- Shipping Table
CREATE TABLE Shipping (
    shipping_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT,
    shipping_address NVARCHAR(255),
    city NVARCHAR(50),
    state NVARCHAR(50),
    postal_code NVARCHAR(20),
    shipped_date DATE,
    delivery_date DATE,
    status NVARCHAR(20) DEFAULT 'Pending' CHECK (status IN ('Pending','In Transit','Delivered','Returned')),
    CONSTRAINT FK_Shipping_Orders FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Reviews Table
CREATE TABLE Reviews (
    review_id INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT,
    customer_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text NVARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Reviews_Products FOREIGN KEY (product_id) REFERENCES Products(product_id),
    CONSTRAINT FK_Reviews_Customers FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Users (Admin/Staff) Table
CREATE TABLE Users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) UNIQUE NOT NULL,
    password_hash NVARCHAR(255) NOT NULL,
    role NVARCHAR(20) DEFAULT 'Staff' CHECK (role IN ('Admin','Manager','Staff')),
    created_at DATETIME DEFAULT GETDATE()
);
