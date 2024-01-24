/* 
Write a query to find the city where not a single order was returned
*/


-- Method-I
SELECT o.city,
       Count(r.order_id) no_of_returned_order
FROM   city_orders AS o
       LEFT JOIN city_returns AS r
              ON o.order_id = r.order_id
GROUP  BY o.city
HAVING Count(r.order_id) = 0 
;

-- Method-II

SELECT DISTINCT city
FROM   city_orders
WHERE  city NOT IN (SELECT DISTINCT city
                    FROM   city_orders
                    WHERE  order_id IN (SELECT order_id FROM   city_returns)) ;

                    
SELECT * FROM city_orders;
SELECT * FROM city_returns;
/*  *************************** Create Statement  ****************************

CREATE TABLE city_orders
  (
     order_id INT,
     city     VARCHAR(10),
     sales    INT
  );

INSERT INTO city_orders
VALUES      (1,'Mysore',100),
            (2,'Mysore',200),
            (3,'Bangalore',250),
            (4,'Bangalore',150),
            (5,'Mumbai',300),
            (6,'Mumbai',500),
            (7,'Mumbai',800);

CREATE TABLE city_returns
  (
     order_id      INT,
     return_reason VARCHAR(20)
  );

INSERT INTO city_returns 
VALUES      (3,'wrong item'),
            (6,'bad quality'),
            (7,'wrong item'); 

             */