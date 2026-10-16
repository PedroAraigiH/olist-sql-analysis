SELECT 
    COALESCE(t.product_category_name_english, p.product_category_name, 'unknown') AS category, 
    ROUND(SUM(i.price), 2) AS revenue, 
    COUNT(DISTINCT i.order_id) AS orders 
FROM order_items i 
JOIN orders o ON i.order_id= o.order_id 
JOIN products p ON i.product_id = p.product_id 
LEFT JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name 
WHERE o.order_status = 'delivered'
    AND o.order_delivered_customer_date IS NOT NULL
    AND strftime('%Y-%m', o.order_purchase_timestamp) BETWEEN '2017-01' AND '2018-08'  
GROUP BY category 
ORDER BY revenue 
DESC LIMIT 10;