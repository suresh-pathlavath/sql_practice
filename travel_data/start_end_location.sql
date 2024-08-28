WITH cte AS (
    SELECT 
        customer, 
        start_loc AS location_data, 
        'start_location' AS column_name 
    FROM travel_data    
    UNION    
    SELECT 
        customer, 
        end_loc AS location_data, 
        'end_location' AS column_name 
    FROM travel_data
), 

cte2 AS (
    SELECT 
        *, 
        CASE WHEN column_name = 'start_location' THEN location_data ELSE NULL END AS start_loc,
        CASE WHEN column_name = 'end_location' THEN location_data ELSE NULL END AS end_loc,
        COUNT(*) OVER (PARTITION BY customer, location_data) AS cnt
    FROM cte
    ORDER BY customer, location_data
)

SELECT 
    customer, 
    MAX(start_loc) AS starting_location, 
    MAX(end_loc) AS ending_location 
FROM cte2 
WHERE cnt = 1
GROUP BY customer;

SELECT * FROM travel_data;




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