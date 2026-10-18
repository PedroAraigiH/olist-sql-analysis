WITH customer_orders AS (
    SELECT c.customer_unique_id, COUNT(DISTINCT o.order_id) AS n_orders
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
        AND o.order_delivered_customer_date IS NOT NULL
        AND strftime('%Y-%m', o.order_purchase_timestamp) BETWEEN '2017-01' AND '2018-08' 
    GROUP BY c.customer_unique_id
)
SELECT CASE WHEN n_orders >= 3 THEN '3+' ELSE CAST(n_orders AS TEXT) END AS orders_placed,
       COUNT(*) AS n_customers,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_customers
FROM customer_orders
GROUP BY orders_placed
ORDER BY orders_placed;