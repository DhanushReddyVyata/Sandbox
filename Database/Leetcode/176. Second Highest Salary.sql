/* Write your T-SQL query statement below */

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