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
GROUP BY month;

WITH monthly_revenue AS (
    SELECT
        strftime('%Y-%m', order_purchase_timestamp) AS month,
        COUNT(DISTINCT i.order_id) AS n_orders,
        SUM(price) AS revenue
    FROM orders o
    JOIN order_items i ON o.order_id = i.order_id
    WHERE 
        o.order_status = 'delivered'
        AND o.order_delivered_customer_date IS NOT NULL
        AND strftime('%Y-%m', o.order_purchase_timestamp) BETWEEN '2017-01' AND '2018-08' 
    GROUP BY month
),
revenue_growth AS (
    SELECT
        month,
        n_orders,
        revenue,
        LAG(revenue) OVER (ORDER BY month) AS previous_month_revenue
    FROM monthly_revenue
)
SELECT
    month,
    n_orders,
    revenue,
    previous_month_revenue,
    ROUND(
        (revenue - previous_month_revenue) * 100.0
        / NULLIF(previous_month_revenue, 0),
        2
    ) AS growth_pct
FROM revenue_growth
ORDER BY month;

SELECT AVG(growth_pct) AS Total_Growth_Avg 
FROM (WITH monthly_revenue AS (
    SELECT
        strftime('%Y-%m', order_purchase_timestamp) AS month,
        SUM(price) AS revenue
    FROM orders o
    JOIN order_items i ON o.order_id = i.order_id
    WHERE
        o.order_status = 'delivered'
        AND o.order_delivered_customer_date IS NOT NULL
        AND strftime('%Y-%m', o.order_purchase_timestamp) BETWEEN '2017-01' AND '2018-08' 
    GROUP BY month
),
revenue_growth AS (
    SELECT
        month,
        revenue,
        LAG(revenue) OVER (ORDER BY month) AS previous_month_revenue
    FROM monthly_revenue
)
SELECT
    month,
    revenue,
    previous_month_revenue,
    ROUND(
        (revenue - previous_month_revenue) * 100.0
        / NULLIF(previous_month_revenue, 0),
        2
    ) AS growth_pct
FROM revenue_growth
ORDER BY month);