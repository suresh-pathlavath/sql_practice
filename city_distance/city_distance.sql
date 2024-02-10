-- problem statement: write a SQL query to get start and end city of each customer
--method 1 
SELECT * FROM   travel_data;

WITH cte1
     AS (SELECT customer,
                start_loc        AS column_name,
                'start_location' AS location
         FROM   travel_data
         UNION ALL
         SELECT customer, 
                end_loc          AS column_name, 
                'end_location'   AS location
         FROM   travel_data),
     cte2
     AS (SELECT *,
                Count(*) OVER( partition BY customer, column_name) AS cnt
         FROM   cte1)
SELECT customer,
       Max(CASE WHEN location = 'start_location' THEN column_name END) AS start_location,
       Max(CASE WHEN location = 'end_location' THEN column_name END) AS end_location
FROM   cte2
WHERE  cnt = 1
GROUP  BY customer 

-- method 2
SELECT * FROM   travel_data;

SELECT td1.customer,
       Max(CASE WHEN td2.start_loc IS NULL THEN td1.start_loc end) AS start_location,
       Max(CASE WHEN td3.end_loc IS NULL THEN td1.end_loc end) AS end_location
FROM   travel_data AS td1
       LEFT JOIN travel_data AS td2 ON td1.customer = td2.customer AND td1.start_loc = td2.end_loc
       LEFT JOIN travel_data AS td3 ON td1.customer = td3.customer AND td1.end_loc = td3.start_loc
GROUP  BY td1.customer 

/*
CREATE TABLE travel_data (
    customer VARCHAR(10),
    start_loc VARCHAR(50),
    end_loc VARCHAR(50)
);

INSERT INTO travel_data (customer, start_loc, end_loc) VALUES
    ('c1', 'New York', 'Lima'),
    ('c1', 'London', 'New York'),
    ('c1', 'Lima', 'Sao Paulo'),
    ('c1', 'Sao Paulo', 'New Delhi'),
    ('c2', 'Mumbai', 'Hyderabad'),
    ('c2', 'Surat', 'Pune'),
    ('c2', 'Hyderabad', 'Surat'),
    ('c3', 'Kochi', 'Kurnool'),
    ('c3', 'Lucknow', 'Agra'),
    ('c3', 'Agra', 'Jaipur'),
    ('c3', 'Jaipur', 'Kochi');

    */