WITH cte
     AS (SELECT comment,
                translation,
                CASE
                  WHEN translation IS NULL THEN comment
                  WHEN translation IS NOT NULL THEN translation
                END AS expected_output
         FROM   comments_and_translations)
SELECT expected_output
FROM   cte;

SELECT *
FROM   comments_and_translations;
/*

https://www.youtube.com/watch?v=aE623ff7zkM&ab_channel=techTFQ

*/