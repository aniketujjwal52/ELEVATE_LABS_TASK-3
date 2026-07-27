-- ==========================================
-- Task 3 : SQL for Data Analysis
-- Dataset : Olist Ecommerce Dataset
-- Tool : PostgreSQL (pgAdmin 4)
-- ==========================================

-- 1. Display all customers
SELECT *
FROM customers;

-- 2. Display customers from SP state
SELECT customer_id,
       customer_city,
       customer_state
FROM customers
WHERE customer_state = 'SP';

-- 3. Display orders that are delivered
SELECT order_id,
       order_status
FROM orders
WHERE order_status = 'delivered';

-- 4. Display top 10 expensive order items
SELECT order_id,
       product_id,
       price
FROM order_items
ORDER BY price DESC
LIMIT 10;

-- 5. Count customers in each state
SELECT customer_state,
       COUNT(*) AS total_customers
FROM customers
GROUP BY customer_state
ORDER BY total_customers DESC;

-- 6. Count payment methods
SELECT payment_type,
       COUNT(*) AS total_transactions
FROM order_payments
GROUP BY payment_type
ORDER BY total_transactions DESC;

-- 7. Calculate total revenue
SELECT SUM(payment_value) AS total_revenue
FROM order_payments;

-- 8. Calculate average payment
SELECT ROUND(AVG(payment_value),2) AS average_payment
FROM order_payments;

-- 9. Highest payment
SELECT MAX(payment_value) AS highest_payment
FROM order_payments;

-- 10. Lowest payment
SELECT MIN(payment_value) AS lowest_payment
FROM order_payments;

-- 11. INNER JOIN
SELECT
o.order_id,
c.customer_city,
o.order_status
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.customer_id;

-- 12. LEFT JOIN
SELECT
c.customer_id,
c.customer_city,
o.order_status
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;

-- 13. RIGHT JOIN
SELECT
o.order_id,
c.customer_city
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id;

-- 14. Customer payment details
SELECT
c.customer_city,
p.payment_type,
p.payment_value
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_payments p
ON o.order_id = p.order_id;

-- 15. Orders having payment greater than average
SELECT order_id,
       payment_value
FROM order_payments
WHERE payment_value >
(
SELECT AVG(payment_value)
FROM order_payments
);

-- 16. Products having price greater than average
SELECT order_id,
       product_id,
       price
FROM order_items
WHERE price >
(
SELECT AVG(price)
FROM order_items
);

-- 17. Create View
CREATE VIEW customer_order_summary AS
SELECT
c.customer_id,
c.customer_city,
o.order_id,
o.order_status
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id;

-- 18. Display View
SELECT *
FROM customer_order_summary;

-- 19. Create Index
CREATE INDEX idx_customer_id
ON customers(customer_id);

-- 20. Total orders for each customer city
SELECT
c.customer_city,
COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_city
ORDER BY total_orders DESC;