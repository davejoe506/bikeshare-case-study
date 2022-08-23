## Table of Contents

### :one: [Introduction](README.md#one-introduction-1)  
### :two: [Business Task](README.md#two-business-task-1)  
### :three: [Data Sources](README.md#three-data-sources-1)  
### :four: [Data Cleaning and Exploration](README.md#four-data-cleaning-and-exploration-1)  
### :five: [Data Analysis and Visualizations](README.md#five-data-analysis-and-visualizations-1)  
### :six: [Conclusion and Recommendations](README.md#six-conclusion-and-recommendations-1)  
### :seven: [Extending This Analysis](README.md#seven-extending-this-analysis-1)  
&nbsp;
## :one: Introduction

This case study is the capstone project of the Google Data Analytics Professional Certificate program. The scenario involves analyzing the trip data for a bikeshare company in Washington DC. 

The company has two general rider types: those who purchase single-ride or full-day passes (casual riders) and those who purchase annual memberships (members). The company believes its future success depends on maximizing the number of annual memberships.

## :two: Business Task

The business task is to determine how members and casual riders use the company's bikeshare services differently. The company is hoping that the insights gained from analyzing its historical bike trip data will drive the design of marketing strategies aimed at converting casual riders into members.

## :three: Data Sources

The bikeshare company used in this case study is fictitious, but for the purposes of this project, I used Washington DC's [Capital Bikeshare historical trip data](https://s3.amazonaws.com/capitalbikeshare-data/index.html) made available by Lyft Bikes and Scooters, LLC under the [Capital Bikeshare Data License Agreement](https://ride.capitalbikeshare.com/data-license-agreement).

Notes:
* The historical trip data is available from 2010 onwards in `.csv` format.
* The business is interested in looking at the previous 12 months of data, so the date range of this analysis is July 2021 to June 2022.
* The data is at the individual trip level and includes fields for:
  * bike type
  * start date and time
  * end date and time 
  * start station name, ID, and location 
  * end station name, ID, and location
  * rider type (member/casual)
* As per the [Capital Bikeshare System Data website](https://ride.capitalbikeshare.com/system-data), the data has been processed to remove trips that are taken by staff as they service and inspect the system, trips that are taken to/from any of their “test” stations at their warehouses, and any trips lasting less than 60 seconds (potentially false starts or users trying to re-dock a bike to ensure it's secure).

## :four: Data Cleaning and Exploration

Since an appended version of the previous 12 months of trip data would be millions of observations, I decided to import the data into a BigQuery database and took the following course of action to clean and explore the data using SQL:

* I appended tables for each month from July 2021 to June 2022 to create one table that covers the previous year of trips. The appended table has `3,205,919` observations. In addition, I added new fields that could potentially be useful during analysis, including ride length, day of week, and season (i.e. Winter, Spring, etc.) A view of this query can be found [here](https://github.com/davejoe506/bikeshare_case_study/blob/main/1_trips_all_unclean.sql). 
* I conducted the following data validation diagnostics:
  * I checked for duplicate observations and did not find any. A view of this query can be found [here](https://github.com/davejoe506/bikeshare_case_study/blob/main/2_check_dups.sql).
  * I checked for null values in all fields, and found null values in 6 of the 18 fields for a total of `253,340` null values, which is `7.90%` of the total observations. A view of these queries can be found [here](https://github.com/davejoe506/bikeshare_case_study/blob/main/2_check_nulls.sql) and [here](https://github.com/davejoe506/bikeshare_case_study/blob/main/2_null_count.sql).
    * I checked to see if I could deduce any null values based on populated values in corresponding fields (i.e. deducing null start station name values based on populated start latitude and start longitude values), but I was not able to reliably deduce any null values. A view of these queries can be found [here](https://github.com/davejoe506/bikeshare_case_study/blob/main/2_deduce_null_ssn.sql), [here](https://github.com/davejoe506/bikeshare_case_study/blob/main/2_deduce_null_esn.sql), and [here](https://github.com/davejoe506/bikeshare_case_study/blob/main/2_deduce_null_el.sql).
  * I returned lists of the non-overlap values in the start station name and end station name fields. All of the start station name values can be found in the end station name field, and the end station name field contains two additional values: "V1 Warehouse Test Station" and ""Motivate Tech Office". A view of these queries can be found [here](https://github.com/davejoe506/bikeshare_case_study/blob/main/2_ssn_not_in_esn.sql) and [here](https://github.com/davejoe506/bikeshare_case_study/blob/main/2_esn_not_in_ssn.sql).
    * As mentioned in the Data Sources section, trips taken to/from the company's "test" stations at their warehouses should have already been removed, but the appearance of "V1 Warehouse Test Station" and "Motivate Tech Office" values seems to conflict with this statement. I checked to see how many observations contained station name values that included the terms "warehouse" or "office", and found that there were `239` such observations, which is `0.007%` of the total observations. A view of this query can be found [here](https://github.com/davejoe506/bikeshare_case_study/blob/main/2_test_trip_count.sql).
  * Also mentioned in the Data Sources section, trips lasting less than 60 seconds should have already been removed from the data. I checked to confirm this, as well as checked for other potential outlier ride lengths (trips with negative ride lengths, trips lasting longer than 24 hours). In total, I found that there were `47,126` trips with outlier ride lengths, which is `1.47%` of the total observations. A view of this query can be found [here](https://github.com/davejoe506/bikeshare_case_study/blob/main/2_outlier_rl_count.sql).
* Aftering considering the null values, the "test" station values, and the outlier ride length values, I thought it would be appropriate to drop the observations containing them from the analysis. After dropping them, the clean table has `2,917,902` observations, which is `91.02%` of the total observations.  A view of this query can be found [here](https://github.com/davejoe506/bikeshare_case_study/blob/main/3_trips_all_clean.sql).

The aforementioned SQL data cleaning and exploration queries involved using `UNION ALL`, `EXCEPT`, `JOIN`, _aggregate functions_, _window functions_, _common table expressions_, _subqueries_, and various other SQL functions.

## :five: Data Analysis and Visualizations
The following data visualizations were created using Tableau Public.
### Share and Number of Trips by Rider Type
![trips_by_rt](https://user-images.githubusercontent.com/107435563/186161555-6b621974-1b7a-4e2c-baf4-a69f0d2ea7a0.png)
#### **Insight**
* From July 2021 to June 2022, member riders made up around 60% of total trips and took close to 1.76 million trips, or about 600,000 more trips than casual riders.

### Number of Trips by Day of Week and Rider Type
![trips_by_dow_rt](https://user-images.githubusercontent.com/107435563/186161742-94605ac8-627a-4d48-b58c-2e01254fd489.png)
#### **Insights**
* On Saturdays and Sundays, member riders and casual riders took a similar number of trips, taking between 200,000 and 250,000 trips each day during the time period.
* Member riders tended to take more trips on weekdays versus weekends, with daily trips being the most on Wednesdays at over 275,000.
* Casual riders tended to take fewer trips on weekdays versus weekends, with daily trips ranging between 128,000 and 139,000 from Mondays through Thursdays.

### Number of Trips by Month/Season and Rider Type
![trips_by_m_s_rt](https://user-images.githubusercontent.com/107435563/186162681-f0f288b3-00e4-4a46-b26c-7a7ce8827b21.png)
#### **Insights**
* For both member and casual riders, the number of trips in the winter dropped precipitously compared to the number in the other seasons.
* For member riders, the number of trips stayed above 140,000 in each of the non-winter months, with trips peaking in June at close to 195,000 and with trips staying above 170,000 in May, September, and October, respectively.
* While September and October saw a relative resurgence in trips for member riders, these early fall months were not as popular with casual riders. The number of trips was highest for casual members from April to July, staying above 125,000 in each of these months and peaking at close to 165,000 in June.

### Number of Trips by Rider Type and Bike Type
![trips_by_bt_rt](https://user-images.githubusercontent.com/107435563/186163044-110ea0fe-3faf-4271-8c20-290871231fbd.png)
#### **Insights**
* The percentage of electric bike trips of total member rider trips and of total casual rider trips was very similar at nearly 10% each.
* Classic bike trips make up a larger percentage of member trips than casual trips (~90% versus ~71%). The difference in these percentages was made up by the docked bike category that only exists in the casual rider type observations.

### Average Ride Length in Minutes by Rider Type
![avg_rl_by_rt](https://user-images.githubusercontent.com/107435563/186198248-99990a85-b38d-4ae8-bf30-18a0dbad4acd.png)
#### **Insight**
* The average ride length of member riders was less than half that of casual riders (~13 minutes versus ~31 minutes).

### Average Ride Length in Minutes by Day of Week and Rider Type
![avg_rl_by_dow_rt](https://user-images.githubusercontent.com/107435563/186162071-4926c3f0-07df-4d50-a7a8-2659b3602e1d.png)
#### **Insights**
* The average ride length of member riders stayed relatively constant throughout the week, ranging from around 12.5 to 14.5 minutes.
* The average ride length of casual riders was longer on weekends than on weekdays (especially Tuesdays through Thursdays). The average ride length was around 34 minutes on Saturdays and Sundays, which was about 7 minutes longer than the average ride length between Tuesdays and Thursdays. 

### Top 10 Start Stations by Number of Trips for Casual Riders
![top_10_ssn_c_map](https://user-images.githubusercontent.com/107435563/186160390-cccc9f80-0a1c-4249-bc1f-ad59ba2456fc.png)
![top_10_ssn_c](https://user-images.githubusercontent.com/107435563/186160429-5230e0d5-5af6-43a2-bf34-234c2a406cee.png)
#### **Insight**
* Most casual rider trips originated on or near the National Mall, with the Lincoln Memorial being the most popular station to start a trip.

## :six: Conclusion and Recommendations
Based on the analysis, here are my top 3 takeways and my top 3 recommendations to help convert casual riders into members:
* **Takeway #1:** The number of trips for casual riders was highest on weekends from April through July.
  * **Recommendation #1:** Marketing efforts should focus on weekends in late spring and early summer to maximize the number of casual riders that could potentially be converted to members.
* **Takeway #2:** The average ride length of casual riders was more than double that of member riders.
  * **Recommendation #2:** Figuring out ways to make longer rides more appealing as a member versus a casual rider would be beneficial in potentially driving user conversion.
* **Takeway #3:** Most casual rider trips originated on or near the National Mall.
  * **Recommendation #3:** The marketing team should consider deploying resources to the National Mall to capture casual riders that could potentially be converted to members. 

## :seven: Extending This Analysis
'
