WITH

data_model AS (
    SELECT 
        stadium.*,
        CASE WHEN (LAG(people, 2) OVER(ORDER BY id)) >= 100 THEN 1 ELSE 0 END AS lagging_2_exceeds_100,
        CASE WHEN (LAG(people, 1) OVER(ORDER BY id)) >= 100 THEN 1 ELSE 0 END AS lagging_1_exceeds_100,
        CASE WHEN people >= 100 THEN 1 ELSE 0 END AS current_exceeds_100,
        CASE WHEN (LEAD(people, 1) OVER(ORDER BY id)) >= 100 THEN 1 ELSE 0 END AS leading_1_exceeds_100,
        CASE WHEN (LEAD(people, 2) OVER(ORDER BY id)) >= 100 THEN 1 ELSE 0 END AS leading_2_exceeds_100
    FROM stadium
)

SELECT 
    id, 
    visit_date, 
    people
FROM data_model
WHERE 
    (lagging_2_exceeds_100 + lagging_1_exceeds_100 + current_exceeds_100) = 3 OR
    (lagging_1_exceeds_100 + current_exceeds_100 + leading_1_exceeds_100) = 3 OR
    (current_exceeds_100 + leading_1_exceeds_100 + leading_2_exceeds_100) = 3
ORDER BY visit_date
