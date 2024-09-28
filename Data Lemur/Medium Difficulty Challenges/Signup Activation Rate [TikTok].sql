SELECT
  -- COUNT(DISTINCT e.email_id) AS total_registered_users,
  -- COUNT(DISTINCT (CASE WHEN signup_action = 'Confirmed' THEN e.email_id ELSE NULL END)) AS activated_users,
  ROUND(COUNT(DISTINCT (CASE WHEN signup_action = 'Confirmed' THEN e.email_id ELSE NULL END)) / (COUNT(DISTINCT e.email_id)*1.0), 2) AS confirm_rate
FROM emails AS e
LEFT JOIN texts AS t ON t.email_id = e.email_id
