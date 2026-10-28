
CREATE DATABASE SalesBook;
USE SalesBook;

CREATE TABLE sales (
    sale_id    INT           PRIMARY KEY,
    sale_date  DATE          NOT NULL,
    region     VARCHAR(10)   NOT NULL,
    product    VARCHAR(30)   NOT NULL,
    quantity   INT           NOT NULL,
    price      INT           NOT NULL
);

INSERT INTO sales (sale_id, sale_date, region, product, quantity, price) VALUES
(1,  '2026-10-01', 'North', 'Tablet',     3, 22000),
(2,  '2026-10-03', 'South', 'Smartphone', 4, 25000),
(3,  '2026-10-05', 'East',  'Keyboard',   8, 1500),
(4,  '2026-10-08', 'West',  'Smartphone', 2, 25000),
(5,  '2026-10-10', 'North', 'Monitor',    5, 12000),
(6,  '2026-10-12', 'South', 'Laptop',     2, 60000),
(7,  '2026-10-15', 'East',  'Tablet',     4, 22000),
(8,  '2026-10-18', 'West',  'Headphones', 6, 3000),
(9,  '2026-10-20', 'North', 'Keyboard',  10, 1500),
(10, '2026-10-25', 'South', 'Monitor',    3, 12000);

SELECT * FROM sales;

SELECT COUNT(*) AS total_sales FROM sales;

SELECT COUNT(*) AS north_sales
FROM sales
WHERE region = 'North';

SELECT region, COUNT(*) AS number_of_sales
FROM sales
GROUP BY region;

SELECT SUM(quantity) AS total_items_sold
FROM sales;

SELECT SUM(quantity * price) AS total_revenue
FROM sales;

SELECT product, SUM(quantity * price) AS revenue
FROM sales
GROUP BY product;

SELECT AVG(quantity) AS average_quantity
FROM sales;

SELECT AVG(quantity * price) AS avg_sale_value
FROM sales;

SELECT region, AVG(quantity * price) AS avg_sale_value
FROM sales
GROUP BY region;

SELECT MIN(price) AS lowest_price,
       MIN(quantity * price) AS smallest_sale
FROM sales;

SELECT MIN(sale_date) AS first_sale_date
FROM sales;

SELECT region, MIN(quantity * price) AS smallest_sale
FROM sales
GROUP BY region;

SELECT MAX(price) AS highest_price,
       MAX(quantity * price) AS biggest_sale
FROM sales;

SELECT MAX(sale_date) AS latest_sale_date
FROM sales;

SELECT region, MAX(quantity * price) AS biggest_sale
FROM sales
GROUP BY region;

SELECT COUNT(*) AS total_sales,
       SUM(quantity * price) AS total_revenue,
       AVG(quantity * price) AS average_sale,
       MIN(quantity * price) AS smallest_sale,
       MAX(quantity * price) AS biggest_sale
FROM sales;

SELECT region,
       COUNT(*) AS sales,
       SUM(quantity * price) AS revenue,
       AVG(quantity * price) AS average_sale,
       MIN(quantity * price) AS smallest_sale,
       MAX(quantity * price) AS biggest_sale
FROM sales
GROUP BY region
ORDER BY revenue DESC;

SELECT sale_id, sale_date, region, product,
       quantity * price AS sale_value
FROM sales
WHERE quantity * price = (
    SELECT MAX(quantity * price)
    FROM sales
);
