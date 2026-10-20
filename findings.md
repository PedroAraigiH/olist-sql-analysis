**Dataset:** [Brazilian E-Commerce Public Dataset by Olist (Kaggle)](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

## Data checks before starting analysis
- Customers ID count: 99441, from which 96096 are real customers with unique ID. This means that 3345 (3.4%) of orders are repeat orders, meaning they are not that customer's first order.
-> Decision: the customer unique ID is used for customer analysis.

- Orders contain 1 to 21 items with a median of 2 items per order for orders with more than one item. Furthermore, 90.06% (88863) of orders with items are composed of only one item.
-> Decision: Always aggregate items per order before joining.

- Order status : 97% (96478) of orders are delivered, 1.11% (1107) are shipped, 0.63% (625) are cancelled, 0.61% (609) have unavailable status, and <1% are either invoiced, processing, created, or approved.
-> Decision : Only delivered orders are used for revenue and delivery analysis.

- Delivered orders without a delivery date : 8
-> Decision: These orders are excluded from delivery time calculations.

- Orders with several reviews: 547; with several payments: 2961
-> Decision: sum payment_value per order for payments, and get the average score for reviews.

- Orders without items: 775 (with unavailable status: 603 ; canceled: 164 ; created: 5 ; invoiced: 2 ; shipped: 1)
-> Decision: Not used in items or products analysis.

- Months with very few orders: 9/2016 (first month), 10/2016, 11/2016 (no orders), 12/2016, 9/2018, 10/2018 (last month)
-> Decision: exclude these months from analysis since incomplete or very low compared to others. Therefore the range from 1/2017 till 8/2018 is used for the analysis. 

## Analysis scope
Delivered orders (with a delivery date) purchased from 2017-01 to 2018-08: 96203 orders.
Based on the previous checks, all other orders are excluded from revenue and delivery analyses.

## Monthly orders and revenue
- We define revenue as the sum of the items price excluding the freight value.
Analysis: 
- The revenue started with its highest growth after the first month (109.51% of revenue growth compared to the first month revenue). However, the growth then slowed generally over the following months with a compound monthly growth rate of 11.12% over the 19 months period (though Jan 2017 small numbers might have inflated this value).
- The month of november 2017 showed a huge rise in order numbers, and therefore in revenue, with 7288 orders generating a total of 987648.07 in revenue. Nevertheless, these numbers didn't last long as it fell sharply the next month with only 5513 orders and 726033.19 in revenue. The following months showed a rise again.
The top 5 days with the most orders during november 2017 are respectively the: 24th with 1176 orders, 25th with 499 orders (less than the half), 27th with 403, 26th with 391, and 28th with 380. This can be explained by a Black Friday event on the 24th of november 2017. The following month fell back, so the spike may have pulled demand forward rather than lifting it permanently.
- The month of May 2018 recorded the second highest revenue number (977544.69) without being among the top 3 months in terms of order count (6749). 

## Top product categories by revenue
- The top 3 product categories by revenue make 25.92% of the total revenue. The lead goes to 'health_beauty' category with 1229557.50 in revenue corresponding to a 9.33% share of total revenue. In second place we have 'watches_gifts' category with 1163187.91 in revenue (8.83% share), and in third place 'bed_bath_table' with 1022955.77 in revenue (7.76% share). 
- However, this doesn't mean that they are the most ordered categories since the top 3 is respectively: 'bed_bath_table' with 9267 distinct orders, 'health_beauty' with 8610 orders, and 'sports_leisure' with 7512 orders.
- Although the category 'watches_gifts' is the most expensive between the top 3 revenue generators, it is only in the 10th place out of all categories with an average price per item of 198.73 R$. The category 'computers' is in the first place with an average of 1098.92 R$ per item. However, the category's average revenue per order is 211.91 R$. This is only about 1.07 times the average item price (198.73 R$), so most orders in this category contain a single item.

## Delivery time by state
- We define delivery time as the interval of time between the order purchase and its delivery to the customer. 
We selected only states with more than 1000 delivered orders. The average delivery time over all selected states is 15.13 days. The top 3 states with the slowest average delivery time (days) are respectively: CE (21.24), BA (19.33), and PE (18.45).
- The top 5 states in terms of number of sellers are respectively: SP (1849), PR (349), MG (244), SC (190), and RJ (171). All these states are in the southern half of Brazil, which can possibly be the reason behind the northeast states of CE, BA, and PE being the top 3 states in terms of slowest average delivery time while the state of SP is the fastest with an average of 8.74 days.
- To test this hypothesis, we computed the average delivery days for orders with one seller. We found that single seller orders delivered within the same state take 7.9 days on average, while those across different states take 15.2 days. Distance is strongly associated with delivery time, though same-state orders are mostly SP to SP, so other factors may also play a role. 
Orders with several sellers were excluded from this comparison (466 same-state orders, 1.35% of total same state orders; 806 cross-state orders, 1.31%).

## Late delivery vs reviews
- Orders with late delivery compared to the estimated delivery date have an average review score of 2.57/5 (7658 orders). On the other hand, orders delivered on time have an average of 4.3/5 (87902 orders). In addition, 164 orders delivered late got no reviews, compared to 479 for orders delivered on time. In total, 8.13% of orders are delivered late.
- Orders delivered in less than 24h late have an average review score of 4.04 and they consist of 1280 orders (8.36% are 1-star reviews). Orders delivered: 1-2 days late have an average of 3.51 (1355 orders, 18.75% 1-star reviews), 3-5 days late have an average of 2.47 (1366 orders, 48.39% 1-star reviews), 6-10 days late have an average of 1.77 (1634 orders, 67.75% 1-star reviews), and orders with 11+ days late have an average of 1.71 (2023 orders, 69.30% 1-star reviews).
- The share of 1-star reviews for late orders is 46.12% (3532 orders), while the share of a single star review for on time orders is 6.54% (5750 orders).
- In summary, late orders score 1.73 points lower, and about 46% of them get 1 star versus 6.5% of on-time orders, so delays are strongly associated with dissatisfaction.

## Cumulative revenue
- 10% of the total revenue was earned by the end of May 2017 (after 5 months). By the end of September 2017 (after 9 months), revenues had passed 25% of the total. Half of all the revenue was earned by the end of January 2018 (after 13 months).

## Top 3 sellers per category
- For the top 5 categories in terms of revenue ('health_beauty', 'watches_gifts', 'bed_bath_table', 'sports_leisure', 'computers_accessories'), 'watches_gifts' sits on the top of the table in terms of concentration of sales. The top 3 sellers for this category contribute respectively to: 17.1%, 16.2%, and 13.6% of its total revenue, which adds up to 46.9%.
- The 'bed_bath_table' category follows with sellers contributing to respectively: 15.9%, 14.8%, and 5.3% of its total revenue, making a total of 36%. The other three categories all have their top three sellers contributing to only 4-6% each.
- However, for the 'watches_gifts' category, there are only 95 sellers. A category with few sellers is naturally concentrated.

## Repeat customers
- The vast majority of customers ordered only once with a percentage of 97% corresponding to 90307 customers. Only 2.75% ordered twice, representing 2562 customers, and only 0.24% ordered 3 or more times (227 customers). This suggests that retention might be the lever for this marketplace to grow.
- The total adds up to 93096 different customers, which means also that out of the 96096 customers with a unique ID, 3000 customers (3.12%) have no order inside the analysis scope (their orders were cancelled, undelivered, or outside Jan 2017-Aug 2018).