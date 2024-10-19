/*
The goal is to identify the best employee for each month based on the number of projects completed. 
This data will help company recognize and reward their top performers, fostering a culture of achievement  and motivation.
*/
SELECT * FROM project_completions;
with cte as (
    SELECT month, employee_name,COUNT(project_id) as n_project
    FROM project_completions 
    GROUP BY month, employee_name
)
,cte2 AS (
    SELECT month,employee_name, n_project,
    dense_rank() OVER(PARTITION BY MONTH ORDER BY n_project DESC) as rnk 
    from cte 
)
SELECT month, employee_name
FROM cte2 
WHERE rnk = 1

/*

-- Create the project_completions table
CREATE TABLE project_completions (
    employee_id INT NOT NULL,
    employee_name VARCHAR(50) NOT NULL,
    project_id INT NOT NULL,
    project_name VARCHAR(50) NOT NULL,
    completion_date DATE NOT NULL,
    month VARCHAR(7) NOT NULL,
    department VARCHAR(50) NOT NULL,
    PRIMARY KEY (employee_id, project_id, completion_date)
);

-- Insert sample data into the project_completions table
INSERT INTO project_completions (employee_id, employee_name, project_id, project_name, completion_date, month, department) VALUES
(1, 'John Doe', 101, 'Project Alpha', '2024-10-01', '2024-10', 'IT'),
(2, 'Jane Smith', 102, 'Project Beta', '2024-10-05', '2024-10', 'Finance'),
(3, 'Mike Brown', 103, 'Project Gamma', '2024-10-11', '2024-10', 'IT'),
(1, 'John Doe', 104, 'Project Delta', '2024-10-20', '2024-10', 'IT'),
(4, 'Sarah Davis', 105, 'Project Epsilon', '2024-10-22', '2024-10', 'Finance'),
(3, 'Mike Brown', 106, 'Project Zeta', '2024-11-02', '2024-11', 'IT'),
(2, 'Jane Smith', 107, 'Project Theta', '2024-11-10', '2024-11', 'Finance'),
(4, 'Sarah Davis', 108, 'Project Iota', '2024-11-15', '2024-11', 'Finance');

credit: Madhur Jain | LinkedIn
*/