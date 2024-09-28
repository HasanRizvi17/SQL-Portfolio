WITH 

searches_expanded AS (
  SELECT 
    searches, 
    GENERATE_SERIES(1, num_users) AS user_num
  FROM search_frequency
  GROUP BY searches, user_num
)

SELECT PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY searches) AS median
FROM searches_expanded
-- ORDER BY searches, user_num