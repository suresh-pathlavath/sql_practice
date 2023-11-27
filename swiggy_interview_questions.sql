--              *****************       Swiggy Interview Questions         ************************ 

-- Question 1: Year-Over-Year Customer Spend Analysis
        WITH cte AS (
            SELECT
                customer_id,
                YEAR(Purchase_date) AS Yearly,
                SUM(Purchase_amount) AS yearly_amount
            FROM
                swiggy_customer_purchases
            GROUP BY
                1, 2
            ORDER BY
                customer_id, YEAR(Purchase_date)
        )

        SELECT
            customer_id,
            Yearly,
            yearly_amount,
            LAG(yearly_amount) OVER (PARTITION BY customer_id ORDER BY Yearly) AS lag_yearly_amount,
            ROUND(
                (yearly_amount - LAG(yearly_amount) OVER (PARTITION BY customer_id ORDER BY Yearly)) * 1.0 * 100 /
                LAG(yearly_amount) OVER (PARTITION BY customer_id ORDER BY Yearly), 2
            ) AS pct_growth
        FROM
            cte;

        SELECT * FROM swiggy_customer_purchases;


-- Question 2: Find the periods when stock quantity was below 50 units for more than two consecutive days.
    WITH cte AS (        
        SELECT 
            Product_id, 
            Stock_quantity, 
            Date, 
            LAG(Stock_quantity) OVER (PARTITION BY Product_id ORDER BY Date) AS lag_stock,
            LAG(Stock_quantity, 2) OVER (PARTITION BY Product_id ORDER BY Date) AS 2nd_lag_stock, 
            LEAD(Stock_quantity) OVER (PARTITION BY Product_id ORDER BY Date) AS lead_stock,
            LEAD(Stock_quantity, 2) OVER (PARTITION BY Product_id ORDER BY Date) AS 2nd_lead   
        FROM 
            swiggy_supplier_inventory
        ORDER BY 
            Date
    )
    SELECT 
        Product_id, 
        Date, 
        Stock_quantity 
    FROM cte 
    WHERE
        (Stock_quantity >= 50 AND lag_stock < 50 AND 2nd_lag_stock < 50)
        OR
        (Stock_quantity >= 50 AND lead_stock < 50 AND 2nd_lead < 50);

    SELECT * FROM swiggy_supplier_inventory;

-- Question 3: Select Employee_id, Store_id, and rank based on Sale_amount for 2023.
        SELECT
            *,
            DENSE_RANK() OVER (ORDER BY Sale_amount DESC) AS rnk
        FROM
            swiggy_employee_sales;





--  https://www.linkedin.com/posts/shakra-shamim-8ab3a1233_swiggy-sql-dataanalyst-activity-7134760252524175360-Wrz9?utm_source=share&utm_medium=member_desktop
