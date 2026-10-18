WITH seller_category AS (
    SELECT COALESCE(t.product_category_name_english, p.product_category_name, 'unknown') AS category,
           i.seller_id,
           SUM(i.price) AS revenue
    FROM order_items i 
    JOIN orders o ON i.order_id= o.order_id 
    JOIN products p ON i.product_id = p.product_id 
    LEFT JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name 
    WHERE o.order_status = 'delivered'
        AND o.order_delivered_customer_date IS NOT NULL
        AND strftime('%Y-%m', o.order_purchase_timestamp) BETWEEN '2017-01' AND '2018-08'
    GROUP BY category, i.seller_id
),
ranked AS (
    SELECT category, seller_id, revenue,
           ROW_NUMBER() OVER (PARTITION BY category ORDER BY revenue DESC) AS rank_in_category,
           SUM(revenue) OVER (PARTITION BY category) AS category_revenue
    FROM seller_category
)
SELECT category, seller_id, ROUND(revenue, 2) AS revenue, rank_in_category,
       ROUND(100.0 * revenue / category_revenue, 1) AS share_pct
FROM ranked
WHERE rank_in_category <= 3
  AND category IN ('health_beauty', 'watches_gifts', 'bed_bath_table', 'sports_leisure', 'computers_accessories')
ORDER BY category, rank_in_category;