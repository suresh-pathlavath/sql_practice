WITH cte_adult AS(
    SELECT person,
        type,
        ROW_NUMBER() OVER(
            ORDER BY person
        ) as rn
    FROM tiger_analytics
    WHERE type = 'Adult'
),
cte_child AS(
    SELECT person,
        type,
        ROW_NUMBER() OVER(
            ORDER BY person
        ) as rn
    FROM tiger_analytics
    WHERE type = 'Child'
)
SELECT cte_adult.person,
    cte_child.person
FROM cte_adult
    LEFT JOIN cte_child ON cte_adult.rn = cte_child.rn;

SELECT * FROM tiger_analytics;