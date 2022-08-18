--Drops observations containing null values, "test" station values, and outlier ride length values from unclean trips table

SELECT *
FROM `solid-groove-356520.bikeshare.1_trips_all_unclean`
EXCEPT DISTINCT
SELECT *
FROM `solid-groove-356520.bikeshare.1_trips_all_unclean`
WHERE start_station_name IS NULL OR end_station_name IS NULL OR lower(start_station_name) LIKE ("%warehouse%") OR
      lower(end_station_name) LIKE ("%warehouse%") OR lower(end_station_name) LIKE ("%office%") OR ride_length_s < 60 OR 
      ride_length_s > 86400

--There are 2,917,902 "clean" trips, which is 91.02% of the total observations
--Query result saved as view; 3_trips_all_clean
