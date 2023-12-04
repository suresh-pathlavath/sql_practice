WITH cte
     AS (SELECT promotional_visits,
                total_cost_of_promotion,
                Lag(total_cost_of_promotion)
                  OVER() AS lag_cost,
                total_return,
                Lag(total_return)
                  OVER() AS lag_return
         FROM   novartis_promotions)
SELECT promotional_visits,
       total_cost_of_promotion,
       total_return,
       total_cost_of_promotion - Lag(total_cost_of_promotion)
                                   OVER() AS marginal_cost,
       total_return - Lag(total_return)
                        OVER()            AS marginal_return
FROM   cte ;

SELECT * FROM    novartis_promotions;