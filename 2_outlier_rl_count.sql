--Check how many observations include "false start" trips where trips last less than 60 seconds; according to Capital Bikeshare's System Data website, these observations should have been removed from the data
--Check how many observations include trips that last longer than 86,400 seconds (24 hours); while there is no mention of these observations on the System Data website, it is hard to think of a justification for these being "proper" trips, and thus I believe they should be removed from the data; while I chose 24 hours as an arbitrary upper-bound threshold for an "improper" trip, inquiry is needed with the company to determine what the best upper-bound threshold for an "improper" trip should be 

SELECT COUNT(IF(ride_length_s < 0,1,NULL)) AS lt0_rl_count,
       COUNT(IF(ride_length_s >= 0 AND ride_length_s < 60,1,NULL)) AS lt60_rl_count,
       COUNT(IF(ride_length_s > 86400,1,NULL)) AS gt24h_rl_count,
       COUNT(IF(ride_length_s < 0,1,NULL)) + COUNT(IF(ride_length_s >= 0 AND ride_length_s < 60,1,NULL)) + COUNT(IF(ride_length_s > 86400,1,NULL)) AS outlier_rl_count,
       COUNT(*) AS total_trip_count,
       (COUNT(IF(ride_length_s < 0,1,NULL)) + COUNT(IF(ride_length_s >= 0 AND ride_length_s < 60,1,NULL)) + COUNT(IF(ride_length_s > 86400,1,NULL))) / COUNT(*) * 100 AS outlier_rl_pct
FROM `solid-groove-356520.bikeshare.1_trips_all_unclean`

--There are 47,126 trips with outlier ride lengths, which is 1.47% of the total observations
--Query result saved as view; 2_outlier_rl_count
