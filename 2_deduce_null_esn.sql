--Check if null end_station_name values can be deduced using available end_lat and end_lng values

 SELECT sub_c.* 
 FROM (
  SELECT sub_b.*,
         ROW_NUMBER() OVER (PARTITION BY sub_b.end_lat_str, sub_b.end_lng_str ORDER BY sub_b.end_lng_str) AS rank_within_group
  FROM (
    SELECT DISTINCT a.end_station_name,
                    CAST(a.end_lat AS STRING) AS end_lat_str,
                    CAST(a.end_lng AS STRING) AS end_lng_str
    FROM `solid-groove-356520.bikeshare.1_trips_all_unclean` a  
    JOIN (
        SELECT DISTINCT end_lat,
                        end_lng
        FROM `solid-groove-356520.bikeshare.1_trips_all_unclean`
        WHERE end_station_name IS NULL) sub_a --subquery a returns the corresponding end_lat and end_lng values for observations with null end_station_name values
    ON sub_a.end_lat = a.end_lat AND sub_a.end_lng = a.end_lng) sub_b) sub_c --subquery b returns end_lat/end_lng combos that appear multiple times via an inner join; subquery_c creates a window function to assign a rank to each end_lat/end_lng combo that appears multiple times
WHERE sub_c.rank_within_group > 1

--Only end_lat_str=0/end_lng_str=0 appears multiple times under different end_station_name values respectively, but since these seem like placeholder values, there does not seem to be enough information to reliably deduce the missing end_station_name value for this entry
--Query result saved as view; 2_deduce_null_esn
