SELECT DATE_FORMAT(TRANS_DATE, '%Y-%m') as transation_date,
    COUNTRY,
    count(id) as trans_count,
    sum(
        case
            WHEN STATE = 'approved' THEN 1
            ELSE 0
        END
    ) AS approved_count,
    sum(
        case
            WHEN STATE = 'declined' THEN 1
            else 0
        END
    ) AS declined_count,
    sum(AMOUNT) as transaction_total_amount,
    sum(
        case
            when state = 'approved' THEN AMOUNT
        END
    ) as approved_total_amount
from transactions
group by DATE_FORMAT(TRANS_DATE, '%Y-%m'),
    2;
    SELECT * from transactions

    /* 
     Problem statement -
     For the given table calculate the Transaction_count, approved_count, declined_count, transaction_total_amount, approved_total_amount grouped by year_month and country
     
     url: https://media.licdn.com/dms/image/D4D22AQH1cx0-8bRSsw/feedshare-shrink_1280/0/1696611932870?e=1700697600&v=beta&t=bNi_Kbpj01MzuM_ucMttsyyDxz7f-_QXKz3qBZX0Ft4
     */

