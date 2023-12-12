SELECT YEAR(date) AS Year, round(AVG(inflation_rate),2) as "Inflation Rate" 
from inflation_in_india
GROUP BY 1