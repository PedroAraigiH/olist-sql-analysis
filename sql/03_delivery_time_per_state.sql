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
ORDER BY delivery_time DESC