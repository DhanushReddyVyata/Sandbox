/*
Table: Customer

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| customer_id | int     |
| product_key | int     |
+-------------+---------+
product_key is a foreign key to Product table.
Table: Product

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_key | int     |
+-------------+---------+
product_key is the primary key column for this table.
 

Write an SQL query for a report that provides the customer ids from the Customer table that bought all the products in the Product table.

For example:

Customer table:
+-------------+-------------+
| customer_id | product_key |
+-------------+-------------+
| 1           | 5           |
| 2           | 6           |
| 3           | 5           |
| 3           | 6           |
| 1           | 6           |
+-------------+-------------+

Product table:
+-------------+
| product_key |
+-------------+
| 5           |
| 6           |
+-------------+

Result table:
+-------------+
| customer_id |
+-------------+
| 1           |
| 3           |
+-------------+
The customers who bought all the products (5 and 6) are customers with id 1 and 3.
*/

-- Solution 1: Matching the product count for each customer
select customer_id
from customer
group by customer_id
having count(distinct product_key) = (select count(product_key) from Product)

-- Solution 2: Does not accept
with 
All_customer as ( select distinct customer_id from Customer),

All_Combinations as (
   select  AC.customer_id, P.product_key
    from All_customer AC cross join Product P),
    
Non_Customers as (select customer_id from All_combinations
                  where concat(customer_id,product_key) NOT IN (select distinct concat(customer_id,product_key) from Customer ))

select AC.customer_id
from All_customer AC
where AC.customer_id not in (select customer_id from Non_customers)