
CREATE DATABASE BUSINESS;
USE BUSINESS;

CREATE TABLE Customer
(
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15),
    city VARCHAR(30)
);

CREATE TABLE Product
(
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50) NOT NULL,
    category VARCHAR(30),
    price DECIMAL(10,2),
    quantity INT
);

SHOW DATABASES;
SHOW TABLES;
DESC Customer;
DESC Product;

ALTER TABLE Customer
ADD address VARCHAR(100);

DESC Customer;

ALTER TABLE Customer
MODIFY phone VARCHAR(20);

DESC Customer;

ALTER TABLE Customer
RENAME COLUMN city TO customer_city;

DESC Customer;

ALTER TABLE Customer
DROP COLUMN address;

DESC Customer;

INSERT INTO Customer
(customer_name, email, phone, customer_city)
VALUES
('Priya', 'priya@gmail.com', '9876501234', 'Bengaluru'),
('Rahul', 'rahul@gmail.com', '9876501235', 'Coimbatore'),
('Sneha', 'sneha@gmail.com', '9876501236', 'Chennai'),
('Arjun', 'arjun@gmail.com', '9876501237', 'Pune'),
('Kavya', 'kavya@gmail.com', '9876501238', 'Madurai');

SELECT * FROM Customer;

INSERT INTO Product
(product_name, category, price, quantity)
VALUES
('Smartphone', 'Electronics', 25000.00, 12),
('Headphones', 'Electronics', 1800.00, 30),
('Tablet', 'Electronics', 18000.00, 15),
('Dining Table', 'Furniture', 9500.00, 10),
('Bookshelf', 'Furniture', 6500.00, 18);

SELECT * FROM Product;

UPDATE Customer
SET phone = '9123456780'
WHERE customer_id = 1;

SELECT * FROM Customer;

UPDATE Product
SET price = 27000.00
WHERE product_id = 1;

SELECT * FROM Product;

UPDATE Product
SET price = 2000.00,
    quantity = 35
WHERE product_id = 2;

SELECT * FROM Product;

DELETE FROM Customer
WHERE customer_id = 5;

SELECT * FROM Customer;

DELETE FROM Product
WHERE product_id = 5;

SELECT * FROM Product;

SELECT * FROM Customer;
SELECT * FROM Product;

TRUNCATE TABLE Customer;
TRUNCATE TABLE Product;

DROP TABLE Product;
DROP TABLE Customer;

DROP DATABASE BUSINESS;
