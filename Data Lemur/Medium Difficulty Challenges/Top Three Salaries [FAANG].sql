WITH

salaries_ranks AS (
  SELECT
  e.*,
  department_name,
  DENSE_RANK() OVER(PARTITION BY e.department_id ORDER BY salary DESC) AS salary_rank
FROM employee AS e
LEFT JOIN department AS d ON d.department_id = e.department_id
)

SELECT
  department_name,
  name,
  salary
FROM salaries_ranks
WHERE salary_rank <= 3
ORDER BY department_name, salary DESC, name
