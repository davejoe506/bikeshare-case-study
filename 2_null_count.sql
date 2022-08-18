--Checks how many observations include null values

WITH total_trip_count AS ( --temp table 1: returns count of total trips
SELECT 1 AS counter,
       COUNT(*) AS total_trip_count
FROM `solid-groove-356520.bikeshare.1_trips_all_unclean`
),
non_nulls AS ( --temp table 2: returns trips that don't contain null values in any field
SELECT *
FROM `solid-groove-356520.bikeshare.1_trips_all_unclean`
EXCEPT DISTINCT
SELECT *
FROM `solid-groove-356520.bikeshare.1_trips_all_unclean`
WHERE start_station_name IS NULL OR end_station_name IS NULL
),
non_null_count AS ( --temp table 3: returns count of trips that don't contain null values in any field
SELECT 1 AS counter,
       COUNT(*) AS non_null_count
FROM non_nulls
),
count_join AS ( --temp table 4: joins together counts returned in previous temp tables 
SELECT *
FROM total_trip_count t
JOIN non_null_count n ON t.counter=n.counter
) --
SELECT non_null_count,
       total_trip_count - non_null_count AS null_count,
       total_trip_count,
       non_null_count / total_trip_count * 100 AS non_null_pct,
       (total_trip_count - non_null_count) / total_trip_count * 100 AS null_pct
FROM count_join

--There are 253,340 observations with null values, which is 7.90% of the total observations
--Query result saved as view; 2_null_count
