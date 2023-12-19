/* 
1. Return the name of the employee with the lowest salary in department 90. */


select * from hr.employees
where salary = (select min(salary) from hr.employees e
where department_id = 90) and department_id = 90;

/* 2. Select the department name, employee name, and salary of all employees who work in the
human resources or purchasing departments. Compute a rank for each unique salary in both
departments.  */

select department_name, last_name, salary, 
dense_rank()
over (partition by e.department_id
order by salary)
drank from hr.employees e 
left join hr.departments d
on e.department_id = d.department_id
where e.department_id in (30,40);

/*3. Select the 3 employees with minimum salary for department id 50. */
select * from (select department_name, last_name, salary, 
dense_rank()
over (partition by e.department_id
order by salary)
drank from hr.employees e 
left join hr.departments d
on e.department_id = d.department_id
where e.department_id = 50) m
where m.drank in (1, 2);


/* 4. Show first name, last name, salary and previously listed employee’s salary who works in
“IT_PROG” over hire date. */

select
last_name,
first_name, hire_date, salary,
LAG(salary, 1, 0)
over (order by hire_date)
from employees
where job_id = 'IT_PROG';


/* 5. Display details of current job for employees who worked as IT Programmers in the past.*/
select *
from hr.employees e
inner join hr.jobs j on
e.job_id = j.job_id
inner join hr.job_history jh
on e.employee_id = jh.employee_id
where jh.job_id = 'IT_PROG';

select * from employees_copy;



/* 6. Make a copy of the employees table and update the salaries of the employees in the new table
with the maximum salary in their departments. */
drop table employees_copy;

update emp_copy ec set salary=(select max(salary) 
from hr.employees e where e.department_id = ec.department_id);

/* 7. Make a copy of the employees table and update the salaries of the employees in the new table
with a 30 percent increase. */
update emp_copy e set salary=salary*1.3 ;