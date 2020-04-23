/*
Given a Weather table, write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.

+---------+------------------+------------------+
| Id(INT) | RecordDate(DATE) | Temperature(INT) |
+---------+------------------+------------------+
|       1 |       2015-01-01 |               10 |
|       2 |       2015-01-02 |               25 |
|       3 |       2015-01-03 |               20 |
|       4 |       2015-01-04 |               30 |
+---------+------------------+------------------+
For example, return the following Ids for the above Weather table:

+----+
| Id |
+----+
|  2 |
|  4 |
+----+
*/
-- Solution based on checking previous row temperature
-- Wrong Answer
-- Error because previous day might not be in previous row
select W.id
from (
select id, RecordDate, temperature
,lag(temperature, 1) over(order by RecordDate) as yesterday_temperature
from Weather
) W
where W.temperature > W.yesterday_temperature
order by 1

-- Solution 1: Inline subquery using DATEADD function
select w1.id
from Weather w1
where w1.temperature > (select temperature 
                        from weather 
                        where RecordDate = Dateadd(day,-1,w1.RecordDate)
                       )

-- Solution 2: using join
Select W.Id from (
select W1.id, W1.RecordDate as today, W1.Temperature as today_temperature
,W2.RecordDate as yesterday, W2.Temperature as yday_temperature
From Weather W1
left join Weather W2 on W1.RecordDate = DATEADD(day,1,W2.RecordDate)
    ) W
where W.today_temperature > W.yday_temperature