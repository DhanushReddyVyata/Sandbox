/*
Write a SQL query to find all numbers that appear at least three times consecutively.

+----+-----+
| Id | Num |
+----+-----+
| 1  |  1  |
| 2  |  1  |
| 3  |  1  |
| 4  |  2  |
| 5  |  1  |
| 6  |  2  |
| 7  |  2  |
+----+-----+
For example, given the above Logs table, 1 is the only number that appears consecutively for at least three times.

+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
*/

-- clever solution
select distinct L1.num ConsecutiveNums
from Logs L1
join Logs L2 on L2.Id-1 = L1.Id and L2.Num = L1.Num
join Logs L3 on L3.Id-2 = L1.Id and L3.Num = L1.Num

-- Solution based on window functions
select distinct L2.num ConsecutiveNums 
from
(select num
,(lag(num,1) over (order by id)) before
,(lead(num, 1) over(order by id)) after
from Logs )  L2
where L2.num = L2.before and L2.num = L2.after