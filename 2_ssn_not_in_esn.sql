--Check for values in start_station_name that are not present in end_station_name

SELECT start_station_name 
FROM `solid-groove-356520.bikeshare.1_trips_all_unclean`
EXCEPT DISTINCT
SELECT end_station_name 
FROM `solid-groove-356520.bikeshare.1_trips_all_unclean`

--Query result saved as view; 2_ssn_not_in_esn
