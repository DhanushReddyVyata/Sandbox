/* Write your T-SQL query statement below */
select top 1 Sal.Salary as SecondHighestSalary
from (
Select top 2 Salary 
from Employee
order by Salary desc
) as Sal
order by Sal.Salary