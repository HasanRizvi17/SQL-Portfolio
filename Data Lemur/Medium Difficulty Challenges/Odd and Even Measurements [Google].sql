WITH

measurement_numbers AS (
  SELECT 
    m.*,
    DATE(measurement_time) AS measurement_day,
    ROW_NUMBER() OVER(PARTITION BY DATE(measurement_time) ORDER BY measurement_time) AS nth_measurement_of_day
  FROM measurements AS m
)

SELECT 
  measurement_day,
  SUM(CASE WHEN nth_measurement_of_day % 2 != 0 THEN measurement_value ELSE 0 END) AS odd_sum,
  SUM(CASE WHEN nth_measurement_of_day % 2 = 0 THEN measurement_value ELSE 0 END) AS even_sum
FROM measurement_numbers
GROUP BY measurement_day
ORDER BY measurement_day
