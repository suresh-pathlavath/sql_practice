WITH cte AS (
    SELECT *, 
           MAX(population) OVER(PARTITION BY state) AS max_population, 
           MIN(population) OVER(PARTITION BY state) AS min_population
    FROM city_population
),
cte2 AS (
    SELECT state, 
           city, 
           population,
           CASE WHEN population = max_population THEN city ELSE NULL END AS max_city,
           CASE WHEN population = min_population THEN city ELSE NULL END AS min_city
    FROM cte
)
SELECT state, 
       MAX(max_city) AS most_population, 
       MIN(min_city) AS least_population
FROM cte2
GROUP BY state;

SELECT * FROM city_population;

/*
CREATE TABLE city_population (
    state VARCHAR(50),
    city VARCHAR(50),
    population INT
);

-- Insert the data
INSERT INTO city_population (state, city, population) VALUES ('haryana', 'ambala', 100);
INSERT INTO city_population (state, city, population) VALUES ('haryana', 'panipat', 200);
INSERT INTO city_population (state, city, population) VALUES ('haryana', 'gurgaon', 300);
INSERT INTO city_population (state, city, population) VALUES ('punjab', 'amritsar', 150);
INSERT INTO city_population (state, city, population) VALUES ('punjab', 'ludhiana', 400);
INSERT INTO city_population (state, city, population) VALUES ('punjab', 'jalandhar', 250);
INSERT INTO city_population (state, city, population) VALUES ('maharashtra', 'mumbai', 1000);
INSERT INTO city_population (state, city, population) VALUES ('maharashtra', 'pune', 600);
INSERT INTO city_population (state, city, population) VALUES ('maharashtra', 'nagpur', 300);
INSERT INTO city_population (state, city, population) VALUES ('karnataka', 'bangalore', 900);
INSERT INTO city_population (state, city, population) VALUES ('karnataka', 'mysore', 400);
INSERT INTO city_population (state, city, population) VALUES ('karnataka', 'mangalore', 200);

credit: Ankit Bansal (EXL Analytics SQL Interview Question | 2 Different Ways of using Window Functions)

*/