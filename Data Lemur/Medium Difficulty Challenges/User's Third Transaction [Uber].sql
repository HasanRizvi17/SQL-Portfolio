WITH

transaction_sequence AS (
  SELECT
  transactions.*,
  ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date) AS nth_transaction
FROM transactions
)

SELECT
  user_id,
  spend,
  transaction_date
FROM transaction_sequence
WHERE nth_transaction = 3
