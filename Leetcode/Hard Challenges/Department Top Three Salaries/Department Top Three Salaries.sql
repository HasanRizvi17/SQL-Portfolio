WITH

rankings AS (
    SELECT
        d.name AS Department,
        e.name AS Employee,
        e.salary AS Salary,
        DENSE_RANK() OVER(PARTITION BY d.name ORDER BY e.salary DESC) AS ranking
    FROM Employee AS e
    LEFT JOIN Department AS d ON d.id = e.departmentId
)

SELECT Department, Employee, Salary
FROM rankings
WHERE ranking <= 3
ORDER BY Department, Salary