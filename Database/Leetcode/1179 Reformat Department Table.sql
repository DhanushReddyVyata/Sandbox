/* 
Table: Department

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| revenue       | int     |
| month         | varchar |
+---------------+---------+
(id, month) is the primary key of this table.
The table has information about the revenue of each department per month.
The month has values in ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"].
 

Write an SQL query to reformat the table such that there is a department id column and a revenue column for each month.

The query result format is in the following example:

Department table:
+------+---------+-------+
| id   | revenue | month |
+------+---------+-------+
| 1    | 8000    | Jan   |
| 2    | 9000    | Jan   |
| 3    | 10000   | Feb   |
| 1    | 7000    | Feb   |
| 1    | 6000    | Mar   |
+------+---------+-------+

Result table:
+------+-------------+-------------+-------------+-----+-------------+
| id   | Jan_Revenue | Feb_Revenue | Mar_Revenue | ... | Dec_Revenue |
+------+-------------+-------------+-------------+-----+-------------+
| 1    | 8000        | 7000        | 6000        | ... | null        |
| 2    | 9000        | null        | null        | ... | null        |
| 3    | null        | 10000       | null        | ... | null        |
+------+-------------+-------------+-------------+-----+-------------+

Note that the result table has 13 columns (1 for the department id + 12 for the months).
*/
-- Clever solution, without pivot
select id
,sum(case when month = 'Jan' then revenue else null end) as Jan_Revenue
,sum(case when month = 'Feb' then revenue else null end) as Feb_Revenue
,sum(case when month = 'Mar' then revenue else null end) as Mar_Revenue
,sum(case when month = 'Apr' then revenue else null end) as Apr_Revenue
,sum(case when month = 'May' then revenue else null end) as May_Revenue
,sum(case when month = 'Jun' then revenue else null end) as Jun_Revenue
,sum(case when month = 'Jul' then revenue else null end) as Jul_Revenue
,sum(case when month = 'Aug' then revenue else null end) as Aug_Revenue
,sum(case when month = 'Sep' then revenue else null end) as Sep_Revenue
,sum(case when month = 'Oct' then revenue else null end) as Oct_Revenue
,sum(case when month = 'Nov' then revenue else null end) as Nov_Revenue
,sum(case when month = 'Dec' then revenue else null end) as Dec_Revenue
from Department
group by id
order by id

--Clever Solution2, without pivot
Select Ids.Id
,dJan.revenue as Jan_Revenue
,dFeb.Revenue as Feb_Revenue
,dMar.Revenue as Mar_Revenue
,dApr.Revenue as Apr_Revenue
,dMay.Revenue as May_revenue
,dJun.Revenue as Jun_Revenue
,dJul.Revenue as Jul_Revenue
,dAug.Revenue as Aug_Revenue
,dSep.Revenue as Sep_revenue
,dOct.Revenue as Oct_Revenue
,dNov.Revenue as Nov_Revenue
,dDec.Revenue as Dec_Revenue
from (Select distinct id from Department) Ids
left join Department dJan on Ids.id = dJan.id and dJan.month = 'Jan'
left join Department dFeb on Ids.id = dFeb.id and dFeb.month = 'Feb'
left join Department dMar on Ids.id = dMar.id and dMar.month = 'Mar'
left join Department dApr on Ids.id = dApr.id and dApr.month = 'Apr'
left join Department dMay on Ids.id = dMay.id and dMay.month = 'May'
left join Department dJun on Ids.id = dJun.id and dJun.month = 'Jun'
left join Department dJul on Ids.id = dJul.id and dJul.month = 'Jul'
left join Department dAug on Ids.id = dAug.id and dAug.month = 'Aug'
left join Department dSep on Ids.id = dSep.id and dSep.month = 'Sep'
left join Department dOct on Ids.id = dOct.id and dOct.month = 'Oct'
left join Department dNov on Ids.id = dNov.id and dNov.month = 'Nov'
left join Department dDec on Ids.id = dDec.id and dDec.month = 'Dec'

--Simple Solution, with pivot
Select id
,Jan as Jan_Revenue
,Feb as Feb_Revenue
,Mar as Mar_Revenue
,Apr as Apr_Revenue
,May as May_Revenue
,Jun as Jun_Revenue
,Jul as Jul_Revenue
,Aug as Aug_Revenue
,Sep as Sep_Revenue
,Oct as Oct_Revenue
,Nov as Nov_Revenue
,Dec as Dec_Revenue

From Department
Pivot ( sum(revenue)
       For Month in (Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec)
) pvt