## Table of Contents

### :one: [Introduction](README.md#one-introduction)  
### :two: [Business Task](README.md#two-business-task)  
### :three: [Data Sources](README.md#three-data-sources)  
### :four: [Data Exploration and Processing](README.md#four-data-exploration-and-processing)  
### :five: [Data Analysis and Visualizations](README.md#five-data-analysis-and-visualizations)  
### :six: [Conclusion](README.md#six-conclusion)  
### :seven: [Extending This Analysis](README.md#seven-extending-this-analysis)  
&nbsp;
## :one: Introduction

This case study is the capstone project of the Google Data Analytics Professional Certificate program. The scenario involves analyzing the trip data for a bikeshare company in Washington DC. 

The company has two general rider types: those who purchase single-ride or full-day passes (casual riders) and those who purchase annual memberships (members). The company believes its future success depends on maximizing the number of annual memberships.

## :two: Business Task

The business task is to determine how members and casual riders use the company's bikeshare services differently. The company is hoping that the insights gained from analyzing its historical bike trip data will drive the design of marketing strategies aimed at converting casual riders into members.

## :three: Data Sources

The bikeshare company used in this case study is fictitious, but for the purposes of this project, I used Washington DC's [Capital Bikeshare historical trip data](https://s3.amazonaws.com/capitalbikeshare-data/index.html) made available by Lyft Bikes and Scooters, LLC under the [Capital Bikeshare Data License Agreement](https://ride.capitalbikeshare.com/data-license-agreement).

Notes
* The historical trip data is available from 2010 onwards in `.csv` format.
* The business is interested in looking at the previous 12 months of data, so the date range of this analysis is July 2021 to June 2022.
* The data is at the individual trip level and includes fields for:
  * bike type
  * start date and time
  * end date and time 
  * start station name, ID, and location 
  * end station name, ID, and location
  * rider type (member/casual).
* As per the [Capital Bikeshare System Data website](https://ride.capitalbikeshare.com/system-data), the data has been processed to remove trips that are taken by staff as they service and inspect the system, trips that are taken to/from any of their “test” stations at their warehouses, and any trips lasting less than 60 seconds (potentially false starts or users trying to re-dock a bike to ensure it's secure).

## :four: Data Exploration and Processing

Since an appended version of the previous 12 months of trip data would be millions of observations, I decided to import the data into BigQuery and took the following course of action to explore and process the data using SQL:

* I appended tables for each month from July 2021 to June 2022 to create one table that covers the previous year of trips. The appended table has `3,205,919` observations. In addition, I added new fields that could potentially be useful during analysis, including ride length, day of week, and season (i.e. Winter, Spring, etc.) A view of this query can be found [here](v_trips_all_unclean). 
* I conducted the following data validation diagnostics:
  * I checked for duplicate observations and did not find any. A view of this query can be found [here](v_check_dups).
  * I checked for null values in all fields, and found null values in 6 of the 18 fields for a total of `253,340` null values, which is `7.90%` of the total observations. A view of these queries can be found [here](v_check_nulls) and [here](v_null_count).
    * I checked to see if I could deduce any null values based on populated values in corresponding fields (i.e. deducing null start station name values based on populated start latitude and start longitude values), but I was not able to reliably deduce any null values. A view of these queries can be found [here](v_deduce_null_ssn), [here](v_deduce_null_esn), and [here](v_deduce_null_el).
  * I returned lists of the non-overlap values in the start station name and end station name fields. All of the start station name values can be found in the end station name field, and the end station name field contains two additional values: "V1 Warehouse Test Station" and ""Motivate Tech Office". A view of these queries can be found [here](v_ssn_not_in_esn) and [here](v_esn_not_in_ssn).
    * As mentioned in the Data Sources section, trips taken to/from the company's "test" stations at their warehouses should have already been removed, but the appearance of "V1 Warehouse Test Station" and "Motivate Tech Office" values seems to conflict with this statement. I checked to see how many observations contained station name values that included the terms "warehouse" or "office, and found that there were `239` such observations, which is `0.007%` of the total observations. A view of this query can be found [here](v_test_trip_count).
  * Also mentioned in the Data Sources section, trips lasting less than 60 seconds should have already been removed from the data. I checked to confirm this, as well as checked for other potential outlier ride lengths (trips with negative ride lengths, trips lasting longer than 24 hours). In total, I found that there were `47,126` trips with outlier ride lengths, which is `1.47%` of the total observations. A view of this query can be found [here](v_outlier_rl_count).
* Aftering considering the null values, the "test" station values, and the outlier ride length values, I thought it would be appropriate to drop them from the analysis. After dropping them, the clean table has `2,917,902` observations, which is `91.02%` of the total observations

The aforementioned SQL data exploration and processing involved 

## :five: Data Analysis and Visualizations

## :six: Conclusion

## :seven: Extending This Analysis
