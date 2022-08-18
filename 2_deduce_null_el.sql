--Check if end_station_name values could potentially be used to deduce null end_lat values

SELECT * 
FROM `solid-groove-356520.bikeshare.1_trips_all_unclean`
WHERE end_station_name IS NOT NULL AND
      end_lat IS NULL

--No null end_late values exist where end_station_name is not null, so null end_lat values cannot be deduced
--Query result saved as view: 2_deduce_null_el
