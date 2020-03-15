/*
Suppose that a website contains two tables, the Customers table and the Orders table. Write a SQL query to find all customers who never order anything.

Table: Customers.

+----+-------+
| Id | Name  |
+----+-------+
| 1  | Joe   |
| 2  | Henry |
| 3  | Sam   |
| 4  | Max   |
+----+-------+
Table: Orders.

+----+------------+
| Id | CustomerId |
+----+------------+
| 1  | 3          |
| 2  | 1          |
+----+------------+
Using the above tables as example, return the following:

+-----------+
| Customers |
+-----------+
| Henry     |
| Max       |
+-----------+
*/

-- Simple Solution 1
select C.Name as Customers 
From Customers C
where ID not in (select CustomerId from Orders)

-- Simple Solution 2
select C2.Name Customers 
From 
(Select C.Name, OD.CustomerID 
 From Customers C
 left join Orders OD on C.Id = OD.CustomerId) C2
where C2.CustomerId is null

-- Simple Solution 3
select C.Name Customers 
From Customers C
left join Orders OD on C.Id = OD.CustomerId
where CustomerId is null