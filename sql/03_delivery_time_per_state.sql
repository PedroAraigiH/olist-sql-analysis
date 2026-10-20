SELECT 
    customer_state, 
    AVG(julianday(order_delivered_customer_date) - julianday(order_purchase_timestamp)) AS delivery_time, 
    COUNT(o.order_id) AS nbr_orders 
FROM orders o 
JOIN customers c ON o.customer_id = c.customer_id 
WHERE o.order_status = 'delivered'
    AND o.order_delivered_customer_date IS NOT NULL
    AND strftime('%Y-%m', o.order_purchase_timestamp) BETWEEN '2017-01' AND '2018-08' 
    AND order_purchase_timestamp IS NOT NULL 
GROUP BY customer_state 
HAVING nbr_orders >1000 
ORDER BY delivery_time DESC;

WITH single_seller_orders AS (
    SELECT order_id, MIN(seller_id) AS seller_id
    FROM order_items
    GROUP BY order_id
    HAVING COUNT(DISTINCT seller_id) = 1
)
SELECT CASE WHEN c.customer_state = s.seller_state THEN 'same state' ELSE 'different state' END AS route,
       COUNT(*) AS n_orders,
       ROUND(AVG(JULIANDAY(o.order_delivered_customer_date) - JULIANDAY(o.order_purchase_timestamp)), 1) AS avg_days
FROM orders o
JOIN single_seller_orders x ON x.order_id = o.order_id
JOIN sellers s ON x.seller_id = s.seller_id
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
    AND o.order_delivered_customer_date IS NOT NULL
    AND strftime('%Y-%m', o.order_purchase_timestamp) BETWEEN '2017-01' AND '2018-08' 
GROUP BY route;