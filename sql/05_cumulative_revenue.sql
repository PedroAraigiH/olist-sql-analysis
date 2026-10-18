WITH monthly_revenue AS (
    SELECT 
        strftime('%Y-%m', order_purchase_timestamp) AS month, 
        COUNT(DISTINCT i.order_id) AS n_orders, 
        SUM(price) AS revenue
    FROM orders o 
    JOIN order_items i ON o.order_id=i.order_id 
    WHERE 
        o.order_status = 'delivered'
        AND o.order_delivered_customer_date IS NOT NULL
        AND strftime('%Y-%m', o.order_purchase_timestamp) BETWEEN '2017-01' AND '2018-08' 
    GROUP BY month
)
SELECT 
    month,
    revenue,
    SUM(revenue) OVER (ORDER BY month) AS cumulative_revenue,
    ROUND(SUM(revenue) OVER (ORDER BY month)/SUM(revenue) OVER () *100, 2) AS cumulative_share
FROM monthly_revenue;