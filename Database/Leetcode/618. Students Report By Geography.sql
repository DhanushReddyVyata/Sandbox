/*
A U.S graduate school has students from Asia, Europe and America. The students' location information are stored in table student as below.
 

| name   | continent |
|--------|-----------|
| Jack   | America   |
| Pascal | Europe    |
| Xi     | Asia      |
| Jane   | America   |
 

Pivot the continent column in this table so that each name is sorted alphabetically and displayed underneath its corresponding continent. The output headers should be America, Asia and Europe respectively. It is guaranteed that the student number from America is no less than either Asia or Europe.
 

For the sample input, the output is:
 

| America | Asia | Europe |
|---------|------|--------|
| Jack    | Xi   | Pascal |
| Jane    |      |        |
 

Follow-up: If it is unknown which continent has the most students, can you write a query to generate the student report?
*/
-- Solution 1 using full join
Select AM.America, AA.Asia, EU.Europe
From
(select name as America, row_number() over(order by name) as id
from student where continent = 'America') AM
full outer join
(select name as Asia, row_number() over(order by name) as id
from student where continent = 'Asia') AA on AM.id = AA.id
full outer join
(select name as Europe, row_number() over(order by name) as id
from student where continent = 'Europe') EU on AM.id = EU.id

-- Solution using window functions and aggregations
select max(America) America, max(Asia) Asia, max(Europe) Europe
From (
select 
row_number() over(partition by continent order by name) as id
,case when continent = 'America' then name end as America
,case when continent = 'Asia' then name end as Asia
,case when continent = 'Europe' then name end as Europe
from student
) s
group by id