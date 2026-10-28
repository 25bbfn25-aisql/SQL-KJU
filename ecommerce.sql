CREATE TABLE products (
    product_id    INT           PRIMARY KEY AUTO_INCREMENT,
    product_name  VARCHAR(120)  NOT NULL,
    category_id   INT           NOT NULL,
    price         DECIMAL(10,2) NOT NULL CHECK (price > 0),
    cost          DECIMAL(10,2) NOT NULL CHECK (cost > 0),
    stock_qty     INT           NOT NULL DEFAULT 0 CHECK (stock_qty >= 0),
    CONSTRAINT fk_prod_cat FOREIGN KEY (category_id)
        REFERENCES categories(category_id)
);

CREATE TABLE orders (
    order_id     INT         PRIMARY KEY AUTO_INCREMENT,
    customer_id  INT         NOT NULL,
    order_date   DATE        NOT NULL,
    status       VARCHAR(20) NOT NULL DEFAULT 'Placed',
    CONSTRAINT fk_ord_cust FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT           PRIMARY KEY AUTO_INCREMENT,
    order_id      INT           NOT NULL,
    product_id    INT           NOT NULL,
    quantity      INT           NOT NULL CHECK (quantity > 0),
    unit_price    DECIMAL(10,2) NOT NULL,
    discount_pct  DECIMAL(5,2)  NOT NULL DEFAULT 0,
    CONSTRAINT fk_oi_order   FOREIGN KEY (order_id)   REFERENCES orders(order_id),
    CONSTRAINT fk_oi_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE payments (
    payment_id INT           PRIMARY KEY AUTO_INCREMENT,
    order_id   INT           NOT NULL,
    method     VARCHAR(20)   NOT NULL,
    amount     DECIMAL(12,2) NOT NULL,
    paid_on    DATE,
    CONSTRAINT fk_pay_order FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- 1.3 ALTER TABLE: add, modify and drop columns / constraints
ALTER TABLE customers ADD COLUMN phone VARCHAR(15);
ALTER TABLE customers MODIFY COLUMN phone VARCHAR(20) DEFAULT 'NA';
ALTER TABLE payments  ADD COLUMN pay_status VARCHAR(15) NOT NULL DEFAULT 'Paid';
ALTER TABLE products  ADD COLUMN is_active TINYINT NOT NULL DEFAULT 1;
ALTER TABLE products  DROP COLUMN is_active;

-- 1.4 CREATE INDEX to speed up common lookups
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orders_date     ON orders(order_date);
CREATE INDEX idx_items_product   ON order_items(product_id);

-- 1.5 Temporary practice table: CREATE, RENAME, TRUNCATE, DROP
CREATE TABLE temp_coupons (
    coupon_id INT PRIMARY KEY AUTO_INCREMENT,
    code      VARCHAR(20) NOT NULL,
    discount  DECIMAL(5,2)
);
INSERT INTO temp_coupons (code, discount) VALUES ('WELCOME10', 10), ('FEST20', 20);
RENAME TABLE temp_coupons TO coupons;
TRUNCATE TABLE coupons;          -- removes all rows, keeps structure
DROP TABLE coupons;              -- removes the table completely

-- 1.6 Verify structure
SHOW TABLES;
DESCRIBE customers;
DESCRIBE products;
DESCRIBE payments;


INSERT INTO customers (full_name, email, city, state, signup_date, phone) VALUES
('Priya Kumar', 'priya@mail.com', 'Chennai', 'Tamil Nadu', '2024-01-12', '9700000001'),
('Rahul Das', 'rahul@mail.com', 'Kolkata', 'West Bengal', '2024-02-18', '9700000002'),
('Ananya Reddy', 'ananya@mail.com', 'Hyderabad', 'Telangana', '2024-03-22', '9700000003'),
('Karthik Raj', 'karthik@mail.com', 'Coimbatore', 'Tamil Nadu', '2024-04-09', '9700000004'),
('Fatima Noor', 'fatima@mail.com', 'Bengaluru', 'Karnataka', '2024-05-16', '9700000005'),
('Sanjay Shah', 'sanjay@mail.com', 'Surat', 'Gujarat', '2024-06-25', '9700000006'),
('Divya Priya', 'divya2@mail.com', 'Chennai', 'Tamil Nadu', '2025-01-08', '9700000007'),
('Arun Kumar', 'arun@mail.com', 'Pune', 'Maharashtra', '2025-02-11', '9700000008'),
('Sneha Roy', 'sneha@mail.com', 'Kolkata', 'West Bengal', '2025-03-14', '9700000009'),
('Mohammed Ali', 'mohammed@mail.com', 'Mysuru', 'Karnataka', '2025-04-05', '9700000010');


INSERT INTO categories (category_name) VALUES
('Mobiles'),
('Clothing'),
('Furniture'),
('Stationery'),
('Fitness');

INSERT INTO products (product_name, category_id, price, cost, stock_qty) VALUES
('Bluetooth Speaker', 1, 2499.00, 1500.00, 100),
('Smartphone Z5', 1, 18999.00, 14000.00, 35),
('Tablet Air', 1, 32999.00, 26000.00, 20),
('Formal Shirt', 2, 899.00, 400.00, 250),
('Casual Trousers', 2, 1499.00, 750.00, 130),
('Office Chair', 3, 6999.00, 4500.00, 45),
('Study Table', 3, 4999.00, 3200.00, 55),
('Notebook Pack', 4, 299.00, 120.00, 300),
('Dumbbell Set', 5, 1999.00, 1100.00, 90),
('Treadmill Basic', 5, 24999.00, 18000.00, 15),
('Unused Accessory', 1, 799.00, 400.00, 12);



INSERT INTO orders (customer_id, order_date, status) VALUES
(1, '2025-01-10', 'Delivered'),
(2, '2025-01-22', 'Delivered'),
(3, '2025-02-05', 'Delivered'),
(1, '2025-02-19', 'Delivered'),
(4, '2025-03-04', 'Returned'),
(5, '2025-03-18', 'Delivered'),
(6, '2025-04-06', 'Cancelled'),
(7, '2025-04-17', 'Delivered'),
(2, '2025-05-11', 'Delivered'),
(8, '2025-05-29', 'Shipped'),
(9, '2025-06-12', 'Delivered'),
(1, '2025-06-28', 'Delivered'),
(3, '2025-07-16', 'Delivered'),
(4, '2025-08-05', 'Delivered'),
(5, '2025-09-15', 'Delivered'),
(7, '2025-10-03', 'Shipped');


INSERT INTO order_items
(order_id, product_id, quantity, unit_price, discount_pct) VALUES
(1, 1, 2, 2499.00, 10),
(1, 4, 3, 899.00, 0),
(2, 2, 1, 18999.00, 5),
(3, 6, 1, 6999.00, 0),
(3, 8, 2, 299.00, 0),
(4, 3, 1, 32999.00, 8),
(5, 5, 2, 1499.00, 0),
(6, 7, 1, 4999.00, 10),
(6, 9, 2, 1999.00, 0),
(7, 10, 1, 24999.00, 0),
(8, 1, 1, 2499.00, 0),
(8, 5, 1, 1499.00, 5),
(9, 2, 1, 18999.00, 10),
(10, 4, 5, 899.00, 0),
(11, 6, 1, 6999.00, 5),
(11, 8, 3, 299.00, 0),
(12, 1, 3, 2499.00, 15),
(13, 9, 4, 1999.00, 0),
(13, 10, 1, 24999.00, 10),
(14, 3, 1, 32999.00, 0),
(15, 7, 2, 4999.00, 5),
(16, 2, 1, 18999.00, 0);


INSERT INTO customers (full_name, email, city, state, signup_date)
VALUES ('Practice Student', 'practice@mail.com', 'Madurai',
        'Tamil Nadu', '2025-10-10');

DELETE FROM customers WHERE email = 'practice@mail.com';


INSERT INTO payments (order_id, method, amount, paid_on)
SELECT o.order_id,
       ELT(1 + MOD(o.order_id, 4), 'Card', 'UPI', 'COD', 'NetBanking'),
       ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct/100)), 2),
       CASE WHEN o.status = 'Shipped' THEN NULL ELSE o.order_date END
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status <> 'Cancelled'
GROUP BY o.order_id, o.status, o.order_date;

-- 2.3 UPDATE (simple)
UPDATE products SET price = 2799.00 WHERE product_name = 'Wireless Earbuds';

-- 2.4 UPDATE (with expression): 5% price rise for the Books category
UPDATE products
SET price = ROUND(price * 1.05, 2)
WHERE category_id = (SELECT category_id FROM categories WHERE category_name = 'Books');

-- 2.5 UPDATE with JOIN: reduce stock by units already sold
UPDATE products p
JOIN (SELECT product_id, SUM(quantity) AS sold
      FROM order_items GROUP BY product_id) s ON s.product_id = p.product_id
SET p.stock_qty = p.stock_qty - s.sold;

-- 2.6 UPDATE with JOIN: mark payments of returned orders as Refunded, unpaid as Pending
UPDATE payments pay
JOIN orders o ON o.order_id = pay.order_id
SET pay.pay_status = 'Refunded'
WHERE o.status = 'Returned';

UPDATE payments SET pay_status = 'Pending' WHERE paid_on IS NULL;

-- 2.7 INSERT / DELETE a test customer
INSERT INTO customers (full_name, email, city, state, signup_date)
VALUES ('Test User', 'test@mail.com', 'Pune', 'Maharashtra', '2025-10-10');
DELETE FROM customers WHERE email = 'test@mail.com';

-- 2.8 TRANSACTION: ROLLBACK discards, COMMIT saves
START TRANSACTION;
UPDATE products SET stock_qty = 0;               -- accidental mass update
SELECT COUNT(*) AS products_with_zero_stock FROM products WHERE stock_qty = 0;
ROLLBACK;                                        -- undo it
SELECT COUNT(*) AS products_with_zero_stock_after_rollback FROM products WHERE stock_qty = 0;

START TRANSACTION;
UPDATE products SET stock_qty = stock_qty + 50 WHERE product_name = 'Laptop Pro 14';
COMMIT;                                          -- restock saved permanently

-- 2.9 Verify DML results
SELECT product_id, product_name, price, stock_qty FROM products;
SELECT * FROM payments;

/* #####################################################################
   PART 3 : FILTERING
   ##################################################################### */

-- 3.1 IN : customers in Bengaluru or Mumbai
SELECT customer_id, full_name, city FROM customers WHERE city IN ('Bengaluru', 'Mumbai');

-- 3.2 BETWEEN + ORDER BY : mid-priced products
SELECT product_name, price FROM products WHERE price BETWEEN 1000 AND 10000 ORDER BY price;

-- 3.3 LIKE : product names containing 'Pro' or starting with 'Air'
SELECT product_name, price FROM products WHERE product_name LIKE '%Pro%' OR product_name LIKE 'Air%';

-- 3.4 AND / comparison : delivered orders in Q1 2025
SELECT order_id, customer_id, order_date
FROM orders
WHERE status = 'Delivered' AND order_date BETWEEN '2025-01-01' AND '2025-03-31';

-- 3.5 NOT EQUAL : orders that were not delivered
SELECT order_id, order_date, status FROM orders WHERE status <> 'Delivered';

-- 3.6 IS NULL : pending payments
SELECT payment_id, order_id, method, amount, pay_status FROM payments WHERE paid_on IS NULL;

-- 3.7 ORDER BY + LIMIT : top 3 most expensive products
SELECT product_name, price FROM products ORDER BY price DESC LIMIT 3;

-- 3.8 DISTINCT : cities we serve
SELECT DISTINCT city FROM customers ORDER BY city;

/* #####################################################################
   PART 4 : AGGREGATE FUNCTIONS
   ##################################################################### */

-- 4.1 COUNT, SUM, AVG, MIN, MAX on products
SELECT COUNT(*)                AS total_products,
       SUM(stock_qty)          AS total_units_in_stock,
       ROUND(AVG(price), 2)    AS avg_price,
       MIN(price)              AS cheapest,
       MAX(price)              AS costliest
FROM products;

-- 4.2 Total orders and customers
SELECT COUNT(*) AS total_orders, COUNT(DISTINCT customer_id) AS customers_who_ordered FROM orders;

-- 4.3 Inventory value (at cost and at selling price)
SELECT SUM(stock_qty * cost) AS inventory_cost_value,
       SUM(stock_qty * price) AS inventory_retail_value
FROM products;

-- 4.4 Total revenue from valid sales (Delivered + Shipped)
SELECT ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct/100)), 2) AS total_revenue
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
WHERE o.status IN ('Delivered', 'Shipped');

-- 4.5 Collected vs pending payments
SELECT SUM(CASE WHEN paid_on IS NOT NULL THEN amount ELSE 0 END) AS collected,
       SUM(CASE WHEN paid_on IS NULL     THEN amount ELSE 0 END) AS pending
FROM payments;

/* #####################################################################
   PART 5 : GROUPING
   ##################################################################### */

-- 5.1 Customers per city
SELECT city, COUNT(*) AS total_customers FROM customers GROUP BY city ORDER BY total_customers DESC, city;

-- 5.2 Orders by status
SELECT status, COUNT(*) AS order_count FROM orders GROUP BY status ORDER BY order_count DESC;

-- 5.3 Products per category with price statistics
SELECT c.category_name,
       COUNT(p.product_id)    AS products,
       ROUND(AVG(p.price), 2) AS avg_price,
       MIN(p.price)           AS min_price,
       MAX(p.price)           AS max_price
FROM categories c
JOIN products p ON p.category_id = c.category_id
GROUP BY c.category_name;

-- 5.4 Payment method summary
SELECT method, COUNT(*) AS payments, SUM(amount) AS total_amount
FROM payments GROUP BY method ORDER BY total_amount DESC;

-- 5.5 HAVING : customers with 2 or more orders
SELECT customer_id, COUNT(*) AS orders_placed
FROM orders GROUP BY customer_id HAVING COUNT(*) >= 2 ORDER BY orders_placed DESC, customer_id;

-- 5.6 HAVING : products with more than 3 units sold
SELECT product_id, SUM(quantity) AS units_sold
FROM order_items GROUP BY product_id HAVING SUM(quantity) > 3 ORDER BY units_sold DESC;

-- 5.7 Monthly order count (cancelled excluded)
SELECT DATE_FORMAT(order_date, '%Y-%m') AS order_month, COUNT(*) AS orders
FROM orders WHERE status <> 'Cancelled'
GROUP BY DATE_FORMAT(order_date, '%Y-%m') ORDER BY order_month;

/* #####################################################################
   PART 6 : JOINS
   ##################################################################### */

-- 6.1 INNER JOIN : orders with customer names
SELECT o.order_id, c.full_name, o.order_date, o.status
FROM orders o
INNER JOIN customers c ON c.customer_id = o.customer_id
ORDER BY o.order_id
LIMIT 8;

-- 6.2 Multi-table JOIN (5 tables) : full line-item detail
SELECT o.order_id, c.full_name, p.product_name, cat.category_name,
       oi.quantity, oi.discount_pct,
       ROUND(oi.quantity * oi.unit_price * (1 - oi.discount_pct/100), 2) AS line_total
FROM order_items oi
JOIN orders     o   ON o.order_id      = oi.order_id
JOIN customers  c   ON c.customer_id   = o.customer_id
JOIN products   p   ON p.product_id    = oi.product_id
JOIN categories cat ON cat.category_id = p.category_id
ORDER BY o.order_id, p.product_name
LIMIT 10;

-- 6.3 LEFT JOIN : customers who never ordered
SELECT c.customer_id, c.full_name
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL;

-- 6.4 LEFT JOIN : products never sold
SELECT p.product_id, p.product_name
FROM products p
LEFT JOIN order_items oi ON oi.product_id = p.product_id
WHERE oi.order_item_id IS NULL;

-- 6.5 LEFT JOIN : orders with no payment (cancelled)
SELECT o.order_id, o.status
FROM orders o
LEFT JOIN payments pay ON pay.order_id = o.order_id
WHERE pay.payment_id IS NULL;

-- 6.6 RIGHT JOIN : every category and how many products it holds
SELECT cat.category_name, COUNT(p.product_id) AS products
FROM products p
RIGHT JOIN categories cat ON cat.category_id = p.category_id
GROUP BY cat.category_name;

-- 6.7 JOIN + GROUP BY : revenue per category
SELECT cat.category_name,
       ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct/100)), 2) AS revenue
FROM order_items oi
JOIN orders     o   ON o.order_id      = oi.order_id
JOIN products   p   ON p.product_id    = oi.product_id
JOIN categories cat ON cat.category_id = p.category_id
WHERE o.status IN ('Delivered', 'Shipped')
GROUP BY cat.category_name
ORDER BY revenue DESC;

-- 6.8 JOIN + GROUP BY + HAVING : customer spending above 20,000
SELECT c.full_name,
       COUNT(DISTINCT o.order_id) AS orders,
       ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct/100)), 2) AS total_spent
FROM customers c
JOIN orders      o  ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id   = o.order_id
WHERE o.status IN ('Delivered', 'Shipped')
GROUP BY c.customer_id, c.full_name
HAVING total_spent > 20000
ORDER BY total_spent DESC;

-- 6.9 SELF JOIN : customer pairs from the same city
SELECT a.full_name AS customer_1, b.full_name AS customer_2, a.city
FROM customers a
JOIN customers b ON a.city = b.city AND a.customer_id < b.customer_id;

/* #####################################################################
    PART 7 : BUSINESS REPORT
   ##################################################################### */
  
CREATE VIEW v_sales_detail AS
SELECT o.order_id, o.order_date, o.status, c.customer_id, c.full_name, c.state,
       p.product_name, cat.category_name, oi.quantity,
       ROUND(oi.quantity * oi.unit_price * (1 - oi.discount_pct/100), 2) AS revenue,
       ROUND(oi.quantity * p.cost, 2) AS total_cost
FROM order_items oi
JOIN orders     o   ON o.order_id      = oi.order_id
JOIN customers  c   ON c.customer_id   = o.customer_id
JOIN products   p   ON p.product_id    = oi.product_id
JOIN categories cat ON cat.category_id = p.category_id;

-- 7.1 Executive summary
SELECT COUNT(DISTINCT order_id)                          AS total_orders,
       COUNT(DISTINCT customer_id)                       AS active_customers,
       SUM(quantity)                                     AS units_sold,
       ROUND(SUM(revenue), 2)                            AS total_revenue,
       ROUND(SUM(revenue - total_cost), 2)               AS gross_profit,
       ROUND(SUM(revenue - total_cost) / SUM(revenue) * 100, 1) AS profit_margin_pct,
       ROUND(SUM(revenue) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM v_sales_detail
WHERE status IN ('Delivered', 'Shipped');

-- 7.2 Monthly revenue and profit
SELECT DATE_FORMAT(order_date, '%Y-%m') AS order_month,
       COUNT(DISTINCT order_id)         AS orders,
       ROUND(SUM(revenue), 2)           AS revenue,
       ROUND(SUM(revenue - total_cost), 2) AS profit
FROM v_sales_detail
WHERE status IN ('Delivered', 'Shipped')
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY order_month;

-- 7.3 Top 5 customers by revenue
SELECT full_name, ROUND(SUM(revenue), 2) AS revenue
FROM v_sales_detail
WHERE status IN ('Delivered', 'Shipped')
GROUP BY customer_id, full_name
ORDER BY revenue DESC
LIMIT 5;

-- 7.4 State-wise sales
SELECT state, COUNT(DISTINCT order_id) AS orders, ROUND(SUM(revenue), 2) AS revenue
FROM v_sales_detail
WHERE status IN ('Delivered', 'Shipped')
GROUP BY state
ORDER BY revenue DESC;

