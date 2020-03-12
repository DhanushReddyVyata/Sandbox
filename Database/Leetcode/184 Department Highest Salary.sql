/*
The Employee table holds all employees. Every employee has an Id, a salary, and there is also a column for the department Id.

+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Jim   | 90000  | 1            |
| 3  | Henry | 80000  | 2            |
| 4  | Sam   | 60000  | 2            |
| 5  | Max   | 90000  | 1            |
+----+-------+--------+--------------+
The Department table holds all departments of the company.

+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+
Write a SQL query to find employees who have the highest salary in each of the departments. For the above tables, your SQL query should return the following rows (order of rows does not matter).

+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
+------------+----------+--------+
Explanation:

Max and Jim both have the highest salary in the IT department and Henry has the highest salary in the Sales department.
*/

-- Simple solution
select D.name Department, Emp1.name Employee, Emp1.salary
from(
select name , salary, departmentid
,rank()over(partition by departmentid order by salary desc) rnk
from employee) as Emp1
join Department D on Emp1.departmentid = D.id 
where Emp1.rnk=1

-- Simple solution, no rank function
select D.name Department, Emp.name Employee, Emp.Salary
From Employee Emp
join (select departmentId, max(salary) as salary
     from Employee 
     group by departmentId) MaxSal 
     on Emp.Departmentid = MaxSal.DepartmentId and Emp.Salary = MaxSal.Salary
join Department D on Emp.DepartmentID = D.Id