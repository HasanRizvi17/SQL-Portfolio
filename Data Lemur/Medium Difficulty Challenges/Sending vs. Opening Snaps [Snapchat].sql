WITH

time_spent_by_activity AS (
  SELECT
    ab.age_bucket,
    SUM(CASE WHEN activity_type = 'send' THEN time_spent ELSE 0 END) AS time_spent_sending,
    SUM(CASE WHEN activity_type = 'open' THEN time_spent ELSE 0 END) AS time_spent_opening
  FROM activities AS a
  LEFT JOIN age_breakdown AS ab ON ab.user_id = a.user_id
  GROUP BY ab.age_bucket
)

SELECT
  age_bucket,
  ROUND((time_spent_sending / (time_spent_sending + time_spent_opening)) * 100.0, 2) AS send_perc,
  ROUND((time_spent_opening / (time_spent_sending + time_spent_opening)) * 100.0, 2) AS open_perc
FROM time_spent_by_activity