--Creates view with appended monthly datasets and new variables; this will be the view used as input to data cleaning

WITH trips_union AS ( --temp table 1: appends all monthly datasets together using UNION ALL
SELECT *
FROM `solid-groove-356520.bikeshare.trips_202107`
UNION ALL
SELECT *
FROM `solid-groove-356520.bikeshare.trips_202108`
UNION ALL
SELECT *
FROM `solid-groove-356520.bikeshare.trips_202109`
UNION ALL
SELECT *
FROM `solid-groove-356520.bikeshare.trips_202110`
UNION ALL
SELECT *
FROM `solid-groove-356520.bikeshare.trips_202111`
UNION ALL
SELECT *
FROM `solid-groove-356520.bikeshare.trips_202112`
UNION ALL
SELECT *
FROM `solid-groove-356520.bikeshare.trips_202201`
UNION ALL
SELECT *
FROM `solid-groove-356520.bikeshare.trips_202202`
UNION ALL
SELECT *
FROM `solid-groove-356520.bikeshare.trips_202203`
UNION ALL
SELECT *
FROM `solid-groove-356520.bikeshare.trips_202204`
UNION ALL
SELECT *
FROM `solid-groove-356520.bikeshare.trips_202205`
UNION ALL
SELECT *
FROM `solid-groove-356520.bikeshare.trips_202206`
),
trips_new_vars AS ( --temp table 2: adds new variables that may be useful during analysis
SELECT *,
       TIMESTAMP_DIFF(ended_at, started_at, SECOND) AS ride_length_s, --ride length in seconds
       MAKE_INTERVAL(second => TIMESTAMP_DIFF(ended_at, started_at, SECOND)) AS ride_length_intv, --ride length as an interval
       EXTRACT(DAYOFWEEK FROM started_at) AS day_of_week_id, --day of week as a number
       FORMAT_DATE('%A', started_at) AS day_of_week_name, --day of week as a string
       CASE 
         WHEN EXTRACT(MONTH FROM started_at) IN (1,2,12) THEN "Winter"
         WHEN EXTRACT(MONTH FROM started_at) IN (3,4,5) THEN "Spring"
         WHEN EXTRACT(MONTH FROM started_at) IN (6,7,8) THEN "Summer"
         WHEN EXTRACT(MONTH FROM started_at) IN (9,10,11) THEN "Fall"
       END AS season --season
FROM trips_union
)
SELECT *
FROM trips_new_vars

--Query result saved as 1_trips_all_unclean
