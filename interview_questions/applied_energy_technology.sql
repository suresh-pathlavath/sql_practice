-- Calculate the total revenue generated from sales of products in the ‘Electronics’ category.
SELECT SUM(total_price) AS total_revenue
FROM energy_sales AS s
LEFT JOIN energy_products AS p
  ON s.product_id = p.product_id
WHERE p.category = 'Electronics';

-- Retrieve the product name and total sales revenue for each product.
SELECT p.product_name AS product,
       SUM(total_price) AS total_revenue
FROM energy_sales AS s
LEFT JOIN energy_products AS p
  ON s.product_id = p.product_id
GROUP BY p.product_name;

-- Highest Revenue Product
WITH cte AS (
    SELECT p.product_name AS product,
           s.total_price AS price,
           ROW_NUMBER() OVER (ORDER BY total_price DESC) AS rn
    FROM energy_sales AS s
    LEFT JOIN energy_products AS p
      ON s.product_id = p.product_id
)
SELECT product
FROM cte
WHERE rn = 1;

-- Retrieve all records from energy_products and energy_sales
SELECT *
FROM energy_products;

SELECT *
FROM energy_sales;



/*CREATE TABLE energy_products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    category VARCHAR(255),
    unit_price DECIMAL(10, 2)
);

INSERT INTO energy_products (product_id, product_name, category, unit_price) VALUES
(101, 'Laptop', 'Electronics', 500),
(102, 'Smartphone', 'Electronics', 300),
(103, 'Bike', 'Automobile', 30),
(104, 'Keyboard', 'Electronics', 20),
(105, 'Mouse', 'Electronics', 15);

CREATE TABLE energy_sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    quantity_sold INT,
    sale_date DATE,
    total_price DECIMAL(10, 2),
    FOREIGN KEY (product_id) REFERENCES energy_products(product_id)
);

INSERT INTO energy_sales (sale_id, product_id, quantity_sold, sale_date, total_price) VALUES
(1, 101, 5, '2024-01-01', 2500),
(2, 102, 3, '2024-01-02', 900),
(3, 103, 2, '2024-01-02', 60),
(4, 104, 4, '2024-01-03', 80),
(5, 105, 6, '2024-01-03', 90);
*/