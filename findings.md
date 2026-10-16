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
-The revenue started with its highest growth after the first month (109.51% of revenue growth compared to the first month revenue). However, the growth then slowed generally over the following months with a compound monthly growth rate of 11.12% over the 19 months period.
-The month of november 2017 showed a huge rise in order numbers, and therefore in revenue, with 7288 orders generating a total of 822066.77 in revenue. Nevertheless, these numbers didn't last long as it fell sharply the next month with only 5513 orders and 608988.09 in revenue. The following months showed a rise again.
The top 5 days with the most orders during november 2017 are respectively the: 24th with 1176 orders, 25th with 499 orders (less than the half), 27th with 403, 26th with 391, and 28th with 380. This can be explained by a possible Black Friday on the 24th of november 2017. 
-The month of May 2018 recorded the highest revenue number (826314.86) without being among the top 3 months in terms of order count (6749). 

- The top 3 product categories by revenue make 25.92% of the total revenue. The lead goes to 'health_beauty' category with 1229557.50 in revenue corresponding to a 9.33% share of total revenue. In second place we have 'watches_gifts' category with 1163187.91 in revenue (8.83% share), and in thrid place 'bed_bath_table' with 1022955.77 in revenue (7.76% share). 
- However, this doesn't mean that they are the most ordered products since the top 3 is respectively: 'bed_bath_table' with 9267 distinct orders, 'health_beauty' with 8610 orders, and 'sports_leisure' with 7512 orders.

- We define delivery time as the interval of time between the order purchase and its delivery to the customer. 
We selected only states with more than 1000 order delivered towards. The top 3 states with the slowest average delivery time (days) are respectively: CE (21.24), BA (19.33), and PE (18.45).