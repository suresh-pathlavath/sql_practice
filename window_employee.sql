SELECT emp_name,
    salary,
    rank() OVER(
        ORDER BY salary DESC
    ) as rnk,
    DENSE_RANK() OVER(
        ORDER BY salary DESC
    ) dense_rnk,
    ROW_NUMBER() OVER(
        ORDER BY salary DESC
    ) as row_n
FROM employee;
SELECT * FROM employee

    /*
     https://www.youtube.com/watch?v=xMWEVFC4FOk&ab_channel=AnkitBansal
     */