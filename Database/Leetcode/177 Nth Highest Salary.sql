/*
Write a SQL query to get the nth highest salary from the Employee table.

+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
For example, given the above Employee table, the nth highest salary where n = 2 is 200. If there is no nth highest salary, then the query should return null.

+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| 200                    |
+------------------------+
*/

--Perfect Solution1 using Order by
CREATE FUNCTION getNthHighestSalary(@N INT) RETURNS INT AS
BEGIN
    RETURN (
        select distinct salary
        from Employee
        order by Salary desc
        offset @N-1 rows
        fetch next 1 rows only
        
    );
END

-- Perfect Solution2 using Dense Rank
CREATE FUNCTION getNthHighestSalary(@N INT) RETURNS INT AS
BEGIN
    RETURN (
        Select distinct salary
        from (
        select salary, dense_rank() over(order by Salary desc) as rnk
        from Employee
        ) as Sal
        where Sal.rnk = @N
        
    );
END