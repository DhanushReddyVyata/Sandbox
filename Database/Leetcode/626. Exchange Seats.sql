/*
Mary is a teacher in a middle school and she has a table seat storing students' names and their corresponding seat ids.

The column id is continuous increment.
 

Mary wants to change seats for the adjacent students.
 

Can you write a SQL query to output the result for Mary?
 

+---------+---------+
|    id   | student |
+---------+---------+
|    1    | Abbot   |
|    2    | Doris   |
|    3    | Emerson |
|    4    | Green   |
|    5    | Jeames  |
+---------+---------+
For the sample input, the output is:
 

+---------+---------+
|    id   | student |
+---------+---------+
|    1    | Doris   |
|    2    | Abbot   |
|    3    | Green   |
|    4    | Emerson |
|    5    | Jeames  |
+---------+---------+
Note:
If the number of students is odd, there is no need to change the last one's seat.
*/
-- Solution 1 using case statements
select
case 
    when a.id <> a.max_id and id%2 = 0 then a.before
    when a.id <> a.max_id and id%2 = 1 then a.after
    when a.id = a.max_id and max_id%2 = 0 then a.before
    when a.id = a.max_id and max_id%2 = 1 then max_id
end as id
,student
From (
select id, student, id+1 as after, id-1 as before, max(id) over() as max_id
from seat 
 ) a
order by 1

-- Solution 2 using case statements and cross join
select
case 
    when a.id <> a.max_id and id%2 = 0 then a.before
    when a.id <> a.max_id and id%2 = 1 then a.after
    when a.id = a.max_id and max_id%2 = 0 then a.before
    when a.id = a.max_id and max_id%2 = 1 then max_id
end as id
, student
From (
select id, student, id+1 as after, id-1 as before, s.max_id
from seat 
cross join (select max(id) max_id from Seat ) s
 ) a
 order by 1
 
 --Solution 3 Window functions
select 
case 
    when id%2 = 0 then a.before
    when id%2 = 1 then coalesce(a.after,id)
end as id
, student
From (
select id, student
,lead(id,1) over(order by id) as after
,lag(id,1) over(order by id) as before
from seat 
 ) a
order by 1

--Solution 4 simple
select 
case 
    when id%2 = 0 then id-1
    when id%2 = 1 and id not in (select max(id) from seat) then id+1
    else id
end as id
,student
from seat 
order by 1