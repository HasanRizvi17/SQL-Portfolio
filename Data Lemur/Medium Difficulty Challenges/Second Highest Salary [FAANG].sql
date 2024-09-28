WITH

salaries_ranks AS (
  SELECT
  employee.*,
  ROW_NUMBER() OVER(ORDER BY salary DESC) AS salary_rank
FROM employee
)

SELECT
  salary AS second_highest_salary
FROM salaries_ranks
WHERE salary_rank = 2
