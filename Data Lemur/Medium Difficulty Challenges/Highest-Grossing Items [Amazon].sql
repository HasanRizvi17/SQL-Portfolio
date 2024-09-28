WITH

spend_by_category_and_product AS (
  SELECT
    category, 
    product,
    SUM(spend) AS total_spend
  FROM product_spend
  WHERE EXTRACT(YEAR FROM transaction_date) = 2022
  GROUP BY category, product
),

rankings AS (
SELECT
  s.*,
  ROW_NUMBER() OVER(PARTITION BY category ORDER BY total_spend DESC) AS product_rank_in_category
FROM spend_by_category_and_product AS s
)

SELECT
  category,
  product,
  total_spend
FROM rankings
WHERE product_rank_in_category <= 2
ORDER BY category, total_spend DESC
