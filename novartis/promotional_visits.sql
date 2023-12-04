with cte as (SELECT Promotional_visits,
 Total_Cost_of_Promotion, lag(Total_Cost_of_Promotion) OVER() as lag_cost,
 Total_Return, lag(Total_Return) OVER() as lag_return
 FROM novartis_promotions)
 SELECT Promotional_visits, Total_Cost_of_Promotion, Total_Return,
 Total_Cost_of_Promotion - lag(Total_Cost_of_Promotion) OVER() as marginal_cost,
 Total_Return -  lag(Total_Return) OVER() as marginal_return
 FROM cte