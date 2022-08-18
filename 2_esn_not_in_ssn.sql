--Check for values in end_station_name that are not present in start_station_name

SELECT end_station_name 
FROM `solid-groove-356520.bikeshare.1_trips_all_unclean`
EXCEPT DISTINCT
SELECT start_station_name 
FROM `solid-groove-356520.bikeshare.1_trips_all_unclean`

--Query result saved as view; 2_esn_not_in_ssn
