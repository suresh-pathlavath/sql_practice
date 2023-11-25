--show employee manager, senior manager with self join concept
-- https://ik.imagekit.io/suresh29/sql_practice/employee_manager_senior_manager.pdf

SELECT e.emp_id     AS emp_id,
       e.emp_name   AS emp_name,
       m.emp_name   AS manager,
       s_m.emp_name AS senior_manager
FROM   amazon_employee AS e
       LEFT JOIN amazon_employee AS m
              ON e.manager_id = m.emp_id
       LEFT JOIN amazon_employee AS s_m
              ON m.manager_id = s_m.emp_id;

SELECT *
FROM   amazon_employee; 

