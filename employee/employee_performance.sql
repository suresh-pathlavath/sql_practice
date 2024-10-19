-- Problem: You are given two tables; employees and projects.
-- Write an SQL query to find the top 2 employees from  the Finance department who have worked the most hours across all projects.
 
SELECT * FROM employees ;
SELECT * FROM projects;
with cte as (
    SELECT e.e_name as employee, e.department as department,
    p.p_name as project, p.p_hours as p_hours
    FROM employees as e 
    left JOIN projects as p 
    on e.e_id = p.e_id 
    WHERE e.department  = 'Finance'
)
,cte2 AS (SELECT employee, SUM(p_hours) AS total_hours,
rank() OVER(ORDER BY sum(p_hours) DESC) AS rnk 
FROM cte 
GROUP BY employee)
SELECT employee FROM cte2 WHERE rnk <=2;

SELECT e.e_name, 
SUM(p.p_hours) AS total_hours
FROM employees e
JOIN projects p
ON e.e_id = p.e_id
WHERE e.department = 'Finance'
GROUP BY e.e_name
ORDER BY total_hours DESC
LIMIT 2;
/*

-- Create the 'employees' table
CREATE TABLE employees (
    e_id INT PRIMARY KEY,
    e_name VARCHAR(50),
    department VARCHAR(50)
);

-- Insert data into the 'employees' table
INSERT INTO employees (e_id, e_name, department) VALUES 
(1, 'John Doe', 'Finance'),
(2, 'Jane Smith', 'IT'),
(3, 'Mike Brown', 'Finance'),
(4, 'Emma Wilson', 'IT'),
(5, 'Sarah Davis', 'Finance');

-- Create the 'projects' table
CREATE TABLE projects (
    p_id INT PRIMARY KEY,
    e_id INT,
    p_name VARCHAR(50),
    p_hours INT,
    FOREIGN KEY (e_id) REFERENCES employees(e_id)
);

-- Insert data into the 'projects' table
INSERT INTO projects (p_id, e_id, p_name, p_hours) VALUES
(101, 1, 'Project A', 100),
(102, 2, 'Project B', 150),
(103, 3, 'Project A', 120),
(104, 4, 'Project C', 130),
(105, 5, 'Project B', 140);
Credit: Vibhanshu G | LinkedIn
*/