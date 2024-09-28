WITH

lag_timestamps AS (
  SELECT 
    transactions.*,
    LAG(transaction_timestamp, 1) OVER(PARTITION BY merchant_id, credit_card_id ORDER BY transaction_timestamp) AS previous_transaction_timestamp,
    LAG(amount, 1) OVER(PARTITION BY merchant_id, credit_card_id ORDER BY transaction_timestamp) AS previous_transaction_amount
  FROM transactions
),

repeated_payments AS (
  SELECT 
    lag_timestamps.*,
    -- EXTRACT(HOUR FROM AGE(transaction_timestamp, previous_transaction_timestamp)) AS hour_diff,
    -- EXTRACT(MINUTE FROM AGE(transaction_timestamp, previous_transaction_timestamp)) AS minute_diff,
    (60 * EXTRACT(HOUR FROM AGE(transaction_timestamp, previous_transaction_timestamp))) + EXTRACT(MINUTE FROM AGE(transaction_timestamp, previous_transaction_timestamp)) AS minutes_diff
  FROM lag_timestamps
  ORDER BY merchant_id, credit_card_id, transaction_timestamp DESC
  )
  
  SELECT COUNT(DISTINCT transaction_id) AS payment_count
  FROM repeated_payments
  WHERE 
    minutes_diff <= 10 AND
    amount = previous_transaction_amount
  