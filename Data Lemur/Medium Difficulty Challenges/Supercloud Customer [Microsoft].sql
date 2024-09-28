SELECT
  customer_id
  -- COUNT(DISTINCT product_category) AS unique_categories_purchased
FROM customer_contracts AS c
LEFT JOIN products AS p ON p.product_id = c.product_id
GROUP BY customer_id
HAVING 
  COUNT(DISTINCT product_category) = (SELECT COUNT(DISTINCT product_category) FROM products)