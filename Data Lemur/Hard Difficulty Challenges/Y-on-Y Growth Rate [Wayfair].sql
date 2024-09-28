WITH

product_spend AS (
  SELECT 
    EXTRACT(YEAR FROM transaction_date) AS year,
    product_id,
    SUM(spend) AS spend
  FROM user_transactions
  GROUP BY year, product_id
)

SELECT
  c.year,
  c.product_id,
  c.spend AS curr_year_spend,
  p.spend AS prev_year_spend,
  ROUND(
    CASE 
      WHEN p.spend IS NULL THEN NULL
      ELSE ((c.spend / COALESCE(p.spend, 0)) - 1) * 100 
    END,
    2
  ) AS yoy_rate
FROM product_spend AS c
LEFT JOIN product_spend AS p ON 
  p.product_id = c.product_id AND
  p.year = c.year - 1
ORDER BY c.product_id, c.year


