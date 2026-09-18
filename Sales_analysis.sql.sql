create database saledata;

-- Select: view sales record
select * from saledata.sales;

-- Where: sales above 10,000
SELECT order_id, customer_name, total_price FROM saledata.sales WHERE total_price > 10000 ORDER BY total_price DESC;

-- 3. GROUP BY + SUM: revenue by category
SELECT category, SUM(total_price) AS revenue FROM saledata.sales GROUP BY category ORDER BY revenue DESC;

-- 4. GROUP BY + COUNT: number of orders by region
SELECT region, COUNT(DISTINCT order_id) AS order_count FROM saledata.sales GROUP BY region ORDER BY order_count DESC;

-- 5. AVG: average line/order value in this dataset (one row per order)
SELECT AVG(total_price) AS average_order_value FROM saledata.sales;

-- 6. Top 10 customers by total spending
SELECT customer_name, SUM(total_price) AS total_spent
FROM saledata.sales GROUP BY customer_name ORDER BY total_spent DESC LIMIT 10;

-- 7. Top customer
SELECT customer_name, SUM(total_price) AS total_spent
FROM saledata.sales GROUP BY customer_name ORDER BY total_spent DESC LIMIT 1;

-- 8. CASE: classify orders
SELECT order_id, customer_name, total_price,
CASE WHEN total_price >= 10000 THEN 'High Value'
     WHEN total_price >= 5000 THEN 'Medium Value'
     ELSE 'Low Value' END AS order_value_category
FROM saledata.sales ORDER BY total_price DESC;

-- 9. JOIN example using a derived customer summary
SELECT s.customer_name, c.total_spent, s.order_id, s.total_price
FROM saledata.sales s
JOIN (SELECT customer_name, SUM(total_price) AS total_spent FROM saledata.sales GROUP BY customer_name) c
  ON s.customer_name = c.customer_name
ORDER BY c.total_spent DESC;

-- 10. Subquery: orders greater than the overall average
SELECT order_id, customer_name, total_price
FROM saledata.sales
WHERE total_price > (SELECT AVG(total_price) FROM saledata.sales)
ORDER BY total_price DESC;

-- 11. Region revenue
SELECT region, SUM(total_price) AS revenue
FROM saledata.sales GROUP BY region ORDER BY revenue DESC;

-- 12. Category average price
SELECT category, AVG(unit_price) AS avg_unit_price
FROM saledata.sales GROUP BY category ORDER BY avg_unit_price DESC;





