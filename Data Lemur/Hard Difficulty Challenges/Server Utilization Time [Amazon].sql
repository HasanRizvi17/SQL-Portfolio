WITH

server_utilization_2 AS (
  SELECT
    server_utilization.*,
    LAG(session_status, 1) OVER(PARTITION BY server_id ORDER BY status_time) AS previous_session_status,
    LAG(status_time, 1) OVER(PARTITION BY server_id ORDER BY status_time) AS previous_status_time
  FROM server_utilization
),

time_differences AS (
  SELECT
    server_utilization_2.*,
    (status_time - previous_status_time) AS date_diff,
    EXTRACT(DAY FROM (status_time - previous_status_time)) AS day_diff,
    EXTRACT(HOUR FROM (status_time - previous_status_time)) AS hour_diff
  FROM server_utilization_2
  WHERE session_status = 'stop'
)

SELECT
  ROUND(SUM((day_diff * 24) + hour_diff) / 24) AS total_uptime_days
FROM time_differences

