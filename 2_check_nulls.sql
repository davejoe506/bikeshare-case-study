--Check for null values in all fields

SELECT COUNT(IF(ride_id IS NULL,1,NULL)) AS ride_id_null_count,
       COUNT(IF(rideable_type IS NULL,1,NULL)) AS rideable_type_null_count,
       COUNT(IF(started_at IS NULL,1,NULL)) AS started_at_null_count,
       COUNT(IF(ended_at IS NULL,1,NULL)) AS ended_at_null_count,
       COUNT(IF(start_station_name IS NULL,1,NULL)) AS start_station_name_null_count,
       COUNT(IF(start_station_id IS NULL,1,NULL)) AS start_station_id_null_count,
       COUNT(IF(end_station_name IS NULL,1,NULL)) AS end_station_name_null_count,
       COUNT(IF(end_station_id IS NULL,1,NULL)) AS end_station_id_null_count,
       COUNT(IF(start_lat IS NULL,1,NULL)) AS start_lat_null_count,
       COUNT(IF(start_lng IS NULL,1,NULL)) AS start_lng_null_count,
       COUNT(IF(end_lat IS NULL,1,NULL)) AS end_lat_null_count,
       COUNT(IF(end_lng IS NULL,1,NULL)) AS end_lng_null_count,
       COUNT(IF(member_casual IS NULL,1,NULL)) AS member_casual_null_count,
       COUNT(IF(ride_length_s IS NULL,1,NULL)) AS ride_length_s_null_count,
       COUNT(IF(ride_length_intv IS NULL,1,NULL)) AS ride_length_intv_null_count,
       COUNT(IF(day_of_week_id IS NULL,1,NULL)) AS day_of_week_id_null_count,
       COUNT(IF(day_of_week_name IS NULL,1,NULL)) AS day_of_week_name_null_count,
       COUNT(IF(season IS NULL,1,NULL)) AS season_null_count
FROM `solid-groove-356520.bikeshare.1_trips_all_unclean`

--Null values found in 6 of 18 fields: start_startion_name, start_station_id, end_station_name, end_station_id, end_lat, and end_lng
--Query result saved as view; 2_check_nulls
