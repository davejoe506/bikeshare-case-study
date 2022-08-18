--Check for duplicate observations in table

SELECT DISTINCT *
FROM `solid-groove-356520.bikeshare.1_trips_all_unclean`

--Query using DISTINCT has same number of observations (3,205,919) as query without DISTINCT, so no duplicate observations
--Query result saved as view; 2_check_dups
