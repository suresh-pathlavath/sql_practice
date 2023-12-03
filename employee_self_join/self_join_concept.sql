with cte as (
    SELECT e.emp_name AS employee,
        m.emp_name as manager,
        e.manager_id as manager_id,
        e.emp_id AS employee_id,
        m.salary as manager_salary,
        e.salary as employee_salary
    FROM self_join_concept as e
        INNER JOIN self_join_concept as m on e.manager_id = m.emp_id
    where e.salary > m.salary
)
select employee
FROM cte;

SELECT * FROM self_join_concept;
    /*
     find employees whose salary is more than their manager
     https://www.youtube.com/watch?v=G7v7TZ3ylDI&ab_channel=AnkitBansal
     */


