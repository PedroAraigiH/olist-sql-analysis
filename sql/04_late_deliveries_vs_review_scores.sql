WITH review_per_order AS (
    SELECT order_id, AVG(review_score) AS review_score
    FROM order_reviews
    GROUP BY order_id
),
delivery AS (
    SELECT o.order_id,
           CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 'late' ELSE 'on time' END AS delivery_status
    FROM orders o
    WHERE o.order_status = 'delivered'
        AND o.order_delivered_customer_date IS NOT NULL
        AND strftime('%Y-%m', o.order_purchase_timestamp) BETWEEN '2017-01' AND '2018-08' 
)
SELECT d.delivery_status,
       COUNT(*) AS n_orders,
       ROUND(AVG(r.review_score), 2) AS avg_review
FROM delivery d
JOIN review_per_order r ON r.order_id = d.order_id
GROUP BY d.delivery_status;

WITH review_per_order AS (
    SELECT 
        order_id,
        AVG(review_score) AS review_score 
    FROM order_reviews 
    GROUP BY order_id
), 
late_orders AS (
    SELECT 
        o.order_id, 
        JULIANDAY(o.order_delivered_customer_date) - JULIANDAY(o.order_estimated_delivery_date) AS days_late 
    FROM orders o 
    WHERE o.order_status = 'delivered'
        AND o.order_delivered_customer_date IS NOT NULL
        AND strftime('%Y-%m', o.order_purchase_timestamp) BETWEEN '2017-01' AND '2018-08'  
        AND o.order_estimated_delivery_date IS NOT NULL 
        AND o.order_delivered_customer_date > o.order_estimated_delivery_date
) 
SELECT CASE WHEN days_late < 1 THEN 'under 1 day'
        WHEN days_late < 3 THEN '1-2 days'
        WHEN days_late < 6 THEN '3-5 days'
        WHEN days_late < 11 THEN '6-10 days'
        ELSE '11+ days' END AS lateness,
    COUNT(*) AS n_orders, 
    ROUND(AVG(r.review_score), 2) AS avg_review 
FROM late_orders l 
JOIN review_per_order r ON r.order_id = l.order_id 
GROUP BY lateness
ORDER BY MIN(days_late);