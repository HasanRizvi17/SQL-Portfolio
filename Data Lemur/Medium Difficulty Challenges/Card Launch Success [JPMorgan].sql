WITH

card_month_numbers AS (
  SELECT 
    m.*,
    ROW_NUMBER() OVER(PARTITION BY card_name ORDER BY issue_year, issue_month) AS card_month_number
  FROM monthly_cards_issued AS m
)

SELECT card_name, issued_amount
FROM card_month_numbers
WHERE card_month_number = 1
ORDER BY issued_amount DESC