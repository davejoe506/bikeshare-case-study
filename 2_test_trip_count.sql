--Based on 2_esn_not_in_ssn view, check how many observations include trips that may have been taken to/from Capital Bikeshare's "test" stations at their warehouses or offices; according to Capital Bikeshare's System Data website, these observations should have been removed from the data

SELECT COUNT(IF(lower(start_station_name) LIKE ("%warehouse%") OR
                lower(end_station_name) LIKE ("%warehouse%") OR
                lower(end_station_name) LIKE ("%office%"),
                1,NULL)) AS test_trip_count,
       COUNT(*) AS total_trip_count,
       COUNT(IF(lower(start_station_name) LIKE ("%warehouse%") OR
                lower(end_station_name) LIKE ("%warehouse%") OR
                lower(end_station_name) LIKE ("%office%"),
                1,NULL)) / COUNT(*) * 100 AS test_trip_pct
FROM `solid-groove-356520.bikeshare.1_trips_all_unclean`

--There are 239 "test" trips, which is 0.007% of the total observations
--Query result saved as view; 2_test_trip_count
