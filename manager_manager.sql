SELECT e.emp_id as emp_id, e.emp_name as emp_name, m.emp_name as manager ,
s_m.emp_name as senior_manager
from amazon_employee as e
left join amazon_employee as m 
on e.manager_id = m.emp_id
left join amazon_employee as s_m 
on m.manager_id = s_m.emp_id ;
SELECT * from amazon_employee;