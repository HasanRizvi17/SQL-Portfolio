WITH

user_activity AS (
  SELECT 
    DATE_TRUNC('month', event_date) AS month,
    EXTRACT(YEAR FROM event_date) AS year_part,
    EXTRACT(MONTH FROM event_date) AS month_part,
    user_id,
    COUNT(*) AS activity_count
  FROM user_actions
  GROUP BY DATE_TRUNC('month', event_date), year_part, month_part, user_id
)

SELECT
  c.month_part AS month,
  COUNT(*) AS monthly_active_users
FROM user_activity AS c
LEFT JOIN user_activity AS p ON
  p.user_id = c.user_id AND
  p.month = c.month - INTERVAL '1 month'
WHERE 
  c.year_part = 2022 AND
  c.month_part = 7 AND 
  c.activity_count > 0 AND 
  p.activity_count > 0
GROUP BY c.month_part
