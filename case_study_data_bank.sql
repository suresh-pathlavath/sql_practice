SELECT * from customer_regions;
SELECT * from customer_nodes LIMIT 5;
SELECT * from customer_transactions LIMIT 5;


--                     Customer Nodes Exploration


-- 01. How many unique nodes are there on the Data Bank system?

    SELECT COUNT(DISTINCT node_id) AS unique_nodes
    FROM   customer_nodes 

-- 02. What is the number of nodes per region?

    SELECT r.region_name,
        COUNT(node_id) AS no_nodes
    FROM   customer_nodes AS n
    LEFT JOIN customer_regions AS r
                ON n.region_id = r.region_id
    GROUP  BY 1; 
-- 03. How many customers are allocated to each region?

    SELECT r.region_name,
        COUNT(DISTINCT customer_id) AS customers
    FROM   customer_nodes AS n
    LEFT JOIN customer_regions AS r
                ON n.region_id = r.region_id
    GROUP  BY 1
    ORDER  BY customers DESC; 


-- 04. How many days on average are customers reallocated to a different node?

SELECT avg(TIMESTAMPDIFF(day, start_date,end_date))  as avg_reallocation
FROM customer_nodes where end_date != '9999-12-31' ;




-- 05. What is the median, 80th and 95th percentile for this same reallocation days metric for each region?


--                                  ** Customer Transaction **


-- 01. What is the unique count and total amount for each transaction type?

    SELECT txn_type as tranaction_type,
        Count(1) AS number_of_transaction,
        Sum(txn_amount)    AS total_amount
    FROM   customer_transactions
    GROUP  BY 1; 


-- 02. What is the average total historical deposit counts and amounts for all customers?

    WITH cte
        AS (SELECT customer_id,
                    Count(1)        AS cnt,
                    Sum(txn_amount) AS total_amt
            FROM   customer_transactions
            WHERE  txn_type = 'deposit'
            GROUP  BY 1)
    SELECT Avg(cnt)       average_count,
        Avg(total_amt) AS average_amount
    FROM   cte 



-- 03. For each month - how many Data Bank customers make more than 1 deposit and either 1 purchase or 1 withdrawal in a single month?
WITH cte
     AS (SELECT Date_format(txn_date, '%m') AS transaction_month,
                customer_id,
                Sum(CASE WHEN txn_type = 'deposit' THEN 1 ELSE 0 END)    AS deposit_count,
                Sum(CASE WHEN txn_type = 'purchase' THEN 1 ELSE 0 END)   AS purchase_count,
                Sum(CASE WHEN txn_type = 'withdrawal' THEN 1 ELSE 0 END) AS withdrawal_count
         FROM   customer_transactions
         GROUP  BY 1,
                   2)
SELECT transaction_month,
       Count(DISTINCT customer_id) AS customer_count
FROM   cte
WHERE  deposit_count > 1
       AND ( purchase_count > 1
              OR withdrawal_count > 1 )
GROUP  BY 1; 





-- 04. What is the closing balance for each customer at the end of the month?

WITH cte4
     AS (SELECT customer_id,
                DATE_FORMAT(txn_date, '%m') AS transaction_month,
                SUM(CASE
                      WHEN txn_type IN ( 'withdrawal', 'purchase' ) THEN
                      -txn_amount
                      ELSE txn_amount
                    END)                    AS net_amount
         FROM   customer_transactions
         GROUP  BY 1,
                   2)
SELECT customer_id,
       transaction_month,
       net_amount,
       SUM(net_amount)
         over (
           PARTITION BY customer_id
           ORDER BY transaction_month ROWS BETWEEN unbounded preceding AND
         CURRENT ROW)
       AS closing_balance
FROM   cte4
ORDER  BY customer_id,
          transaction_month; 


-- 05. What is the percentage of customers who increase their closing balance by more than 5%?

/*

https://8weeksqlchallenge.com/case-study-4/

https://medium.com/@oluwatobiaina/8-week-sql-challenge-case-study-4-data-bank-be0a9c0b435c

*/