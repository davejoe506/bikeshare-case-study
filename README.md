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

Since an appended version of the previous 12 months of trip data would be millions of observations, I decided to import the data into BigQuery and use SQL to explore and process the data.

* I appended tables for each month from July 2021 to June 2022 to create one table that covers the previous year of trips. The appended table has 3,205,919 observations. In addition, I added new variables that could potentially be useful during analysis, including ride length, day of week, and season (i.e. Winter, Spring, etc.) A view of this query can be found here. 
* To further inspect and explore the appended table, I conducted some data validation diagnostics:
  * I checked for duplicate observations and did not find any. A view of this query can be found here.
  * I checked for null values in all fields. Null values were found in the start station name and ID fields, as well as the end station name, ID, and locational fields, but were not found in any non-station-related fields. A view of this query can be found here.
    * I checked to see if I could deduce any null start station and end station values based on populated values in corresponding fields, but I was not able to reliably deduce any null values. A view of this queries can be found here, here, and here.
  * I returned a list of the distinct values in the start station name and end station name fields and looked at how they compared. All of the start station name values can be found in the end station name field, and the end station name field contains two additional values: "V1 Warehouse Test Station" and ""Motivate Tech Office".
    * 


## :five: Data Analysis and Visualizations

## :six: Conclusion

## :seven: Extending This Analysis
