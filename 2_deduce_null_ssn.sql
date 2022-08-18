--Check if null start_station_name values can be deduced using available start_lat and start_lng values

 SELECT sub_c.* 
 FROM (
  SELECT sub_b.*,
         ROW_NUMBER() OVER (PARTITION BY sub_b.start_lat_str, sub_b.start_lng_str ORDER BY sub_b.start_lng_str) AS rank_within_group
  FROM (
    SELECT DISTINCT a.start_station_name,
                    CAST(a.start_lat AS STRING) AS start_lat_str,
                    CAST(a.start_lng AS STRING) AS start_lng_str
    FROM `solid-groove-356520.bikeshare.1_trips_all_unclean` a  
    JOIN (
        SELECT DISTINCT start_lat,
                        start_lng
        FROM `solid-groove-356520.bikeshare.1_trips_all_unclean`
        WHERE start_station_name IS NULL) sub_a --subquery a returns the corresponding start_lat and start_lng values for observations with null start_station_name values
    ON sub_a.start_lat = a.start_lat AND sub_a.start_lng = a.start_lng) sub_b) sub_c --subquery b returns start_lat/start_lng combos that appear multiple times via an inner join; subquery_c creates a window function to assign a rank to each start_lat/start_lng combo that appears multiple times
WHERE sub_c.rank_within_group > 1

--No null start_station_name values can be deduced using available start_lat and start_lng values
--Query result saved as view; 2_deduce_null_ssn
