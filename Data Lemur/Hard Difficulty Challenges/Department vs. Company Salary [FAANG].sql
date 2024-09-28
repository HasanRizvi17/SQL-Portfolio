WITH 

company_avg AS (
  SELECT AVG(amount) AS company_avg_salary_march
  FROM salary
  WHERE TO_CHAR(payment_date, 'MM-YYYY') = '03-2024'
)

SELECT 
  e.department_id,
  TO_CHAR(s.payment_date, 'MM-YYYY') AS payment_date,
  CASE
    WHEN AVG(s.amount) > (SELECT company_avg_salary_march FROM company_avg) THEN 'higher'
    WHEN AVG(s.amount) = (SELECT company_avg_salary_march FROM company_avg) THEN 'same'
    WHEN AVG(s.amount) < (SELECT company_avg_salary_march FROM company_avg) THEN 'lower'
  END AS comparison
FROM salary AS s
LEFT JOIN employee AS e ON e.employee_id = s.employee_id
WHERE TO_CHAR(s.payment_date, 'MM-YYYY') = '03-2024'
GROUP BY e.department_id, payment_date