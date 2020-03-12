/* Write your T-SQL query statement below */
/*
Write a SQL query to get the second highest salary from the Employee table.

+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
For example, given the above Employee table, the query should return 200 as the second highest salary. If there is no second highest salary, then the query should return null.

+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+

*/

-- Imperfect Solution
select 
case 
when 
(select count(1) from (
Select top 2 Salary
from Employee
group by Salary
order by Salary desc
) as top2Sal) =2 
Then 
(select top 1 top2Sal2.Salary from
                      (select top 2 salary 
                      from Employee
                      order by Salary desc) as top2Sal2
                       order by top2Sal2.Salary asc
                      )

else null
end as SecondHighestSalary


-- Clever Solution
select max(Salary) as SecondHighestSalary
from Employee
where Salary < (Select max(salary) from Employee)


-- Perfect Solution - can be extended to N Levels
Select coalesce(
(select distinct rankedList.salary 
from (
select id, salary
    ,dense_rank() over(order by Salary desc) as rnk 
    from Employee
) rankedList
where rankedList.rnk = 2),Null) as SecondHighestSalary

-- Perfect Solution 2 - can be extended to N Levels
select isnull (
(select distinct salary from Employee
order by Salary desc
offset 1 row
fetch next 1 row only), null) as SecondHighestSalary
