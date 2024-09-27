WITH 

unbanned_users AS (
    SELECT *
    FROM users
    WHERE
        banned = 'No' 
)

SELECT
    request_at AS `Day`,
    -- COUNT(*) AS total_trips,
    -- SUM(CASE WHEN status IN ('cancelled_by_driver', 'cancelled_by_client') THEN 1 ELSE 0 END) AS cancelled_trips,
    ROUND(
        SUM(CASE WHEN status LIKE 'cancelled%' THEN 1 ELSE 0 END)
            / COUNT(*), 
        2
     ) AS `Cancellation Rate`
FROM trips AS t
INNER JOIN unbanned_users AS c ON c.users_id = t.client_id
INNER JOIN unbanned_users AS d ON d.users_id = t.driver_id
WHERE request_at BETWEEN '2013-10-01' and '2013-10-03'
GROUP BY `Day`
ORDER BY `Day`
