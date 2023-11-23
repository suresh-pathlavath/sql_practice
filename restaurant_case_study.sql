


SELECT * from restaurant_members;
SELECT * from restaurant_menu;
SELECT * from restaurant_sales;

/*
https://8weeksqlchallenge.com/case-study-1/

https://chat.openai.com/share/b8d59376-123f-464f-89a7-d491c5c43e22  
*/

-- 01. What is the total amount each customer spent at the restaurant?

        SELECT s.customer_id AS customer_id,
        Sum(price)    AS total_spent
        FROM   restaurant_sales AS s
        LEFT JOIN restaurant_menu AS m
                ON s.product_id = m.product_id
        GROUP  BY customer_id; 


--02. How many days has each customer visited the restaurant?


        SELECT s.customer_id       AS customer_id,
        Count(DISTINCT order_date) AS number_of_days_visits
        FROM   restaurant_sales    AS s
        LEFT JOIN restaurant_menu  AS m
                ON s.product_id = m.product_id
        GROUP  BY customer_id; 


--03. What was the first item from the menu purchased by each customer?


        WITH cte
        AS (SELECT s.customer_id,
                        s.order_date,
                        m.product_name,
                        Row_number()
                        OVER(
                        partition BY customer_id
                        ORDER BY order_date ASC) AS rnk
                FROM   restaurant_sales AS s
                        LEFT JOIN restaurant_menu AS m
                        ON s.product_id = m.product_id)
        SELECT customer_id,
        order_date,
        product_name
        FROM   cte
        WHERE  rnk = 1; 


--04. What is the most purchased item on the menu and how many times was it purchased by all customers?


        WITH cte
        AS
        (
                SELECT    m.product_id,
                        count(customer_id) AS cnt
                FROM      restaurant_sales   AS s
                LEFT JOIN restaurant_menu    AS m
                ON        s.product_id = m.product_id
                GROUP BY  1
                ORDER BY  cnt DESC)
        SELECT product_id,
                cnt AS most_purchased
        FROM   cte
        LIMIT  1;


--05. Which item was the most popular for each customer?

        WITH cte
        AS (SELECT DISTINCT s.customer_id,
                                s.product_id,
                                Count(s.product_id)
                                OVER(
                                partition BY s.product_id) AS cnt
                FROM   restaurant_sales AS s
                        LEFT JOIN restaurant_menu AS m
                        ON s.product_id = m.product_id
                ORDER  BY s.customer_id,
                        s.product_id),
        cte2
        AS (SELECT customer_id,
                        product_id,
                        cnt,
                        Dense_rank()
                        OVER(
                        partition BY customer_id
                        ORDER BY cnt DESC) AS most_popular
                FROM   cte)
        SELECT product_id
        FROM   cte2
        WHERE  most_popular = 1 ;


--06. Which item was purchased first by the customer after they became a member?


        WITH cte
        AS (SELECT m.customer_id,
                        m.join_date,
                        s.order_date   AS order_date,
                        s.product_id,
                        Dense_rank()
                        OVER(
                        partition BY m.customer_id
                        ORDER BY order_date) AS rnk
                FROM   restaurant_members AS m
                        LEFT JOIN restaurant_sales AS s
                        ON m.customer_id = s.customer_id
                                AND m.join_date < s.order_date)
        SELECT customer_id,
        product_id
        FROM   cte
        WHERE  rnk = 1 ;        

--07. Which item was purchased just before the customer became a member?


        WITH cte
        AS (SELECT m.customer_id   AS customer_id,
                        m.join_date     AS join_date,
                        s.order_date    AS order_date,
                        s.product_id,
                        Row_number()
                        OVER(
                        partition BY m.customer_id
                        ORDER BY s.order_date DESC) AS rnk
                FROM   restaurant_members AS m
                        LEFT JOIN restaurant_sales AS s
                        ON m.customer_id = s.customer_id
                                AND s.order_date < m.join_date)
        SELECT customer_id,
        product_id
        FROM   cte
        WHERE  rnk = 1 ;



--08. What is the total items and amount spent for each member before they became a member?

        WITH cte
        AS (SELECT m.customer_id AS customer_id,
                        m.join_date   AS join_date,
                        s.order_date  AS order_date,
                        s.product_id,
                        menu.price
                FROM   restaurant_members AS m
                        LEFT JOIN restaurant_sales AS s
                        ON m.customer_id = s.customer_id
                                AND s.order_date < m.join_date
                        LEFT JOIN restaurant_menu AS menu
                        ON s.product_id = menu.product_id)
        SELECT customer_id,
        SUM(price) AS total_spent
        FROM   cte
        GROUP  BY customer_id ;


--09. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
--10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

