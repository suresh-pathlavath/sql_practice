SELECT * FROM sales_data;
SELECT YEAR(bill_date) as year,
left(date_format(bill_date, "%M"),3) as monthly,total,
sum(total) OVER(ORDER BY date(bill_date), MONTH(bill_date)) as cum_sum,
sum(total) OVER(ORDER BY bill_date ROWS BETWEEN UNBOUNDED PRECEDING and CURRENT ROW) as roll_sum,
sum(total) OVER(PARTITION BY YEAR(bill_date), MONTH(bill_date) ORDER BY bill_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as monthly_cum_sum
FROM sales_data; 

/*

CREATE TABLE sales_data (
    bill_id INT,
    bill_date DATE,
    item_id VARCHAR(10),
    item_description VARCHAR(50),
    quantity INT,
    item_price DECIMAL(10, 2),
    total DECIMAL(10, 2)
);


INSERT INTO sales_data (bill_id, bill_date, item_id, item_description, quantity, item_price, total)
VALUES
(1, '2019-02-05', 'a1', 'xyz', 1, 500, 500),
(1, '2019-02-05', 'b1', 'abc', 2, 200, 400),
(1, '2019-02-05', 'a2', 'lmn', 1, 350, 350),
(1, '2019-02-05', 'b2', 'pqr', 1, 400, 400),
(2, '2019-03-13', 'c1', 'ghi', 1, 320, 320),
(2, '2019-03-13', 'a1', 'xyz', 1, 500, 500),
(2, '2019-03-13', 'b1', 'abc', 1, 200, 200);

*/