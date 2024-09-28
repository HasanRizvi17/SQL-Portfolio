SELECT
  COALESCE(a.user_id, p.user_id) AS user_id,
  CASE
    WHEN a.status IS NULL AND p.paid IS NOT NULL THEN 'NEW'
    WHEN p.paid IS NULL THEN 'CHURN' 
    WHEN a.status IN ('NEW','EXISTING','RESURRECT') AND paid IS NOT NULL THEN 'EXISTING'
    WHEN a.status = 'CHURN' AND p.paid IS NOT NULL THEN 'RESURRECT'
  END AS new_status
FROM advertiser AS a
FULL JOIN daily_pay AS p ON p.user_id = a.user_id
ORDER BY user_id
