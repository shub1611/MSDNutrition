create database if not exists NutritionData;
create external table if not exists NutritionData.Nutrition_Physical_Activity
(
YearStart string,
YearEnd string,
LocationAbbr string,
LocationDesc string,
Datasource string,
Class string,
Topic string,
Question string,
Data_Value_Unit string,
Data_Value_Type string,
Data_Value string,
Data_Value_Alt string,
Data_Value_Footnote_Symbol string,
Data_Value_Footnote string,
Low_Confidence_Limit string,
High_Confidence_Limit string,
Sample_Size string,
Total string,
Age_in_months string,
Gender string,
Race_or_Ethnicity string,
GeoLocation string,
ClassID string,
TopicID string,
QuestionID string,
DataValueTypeID string,
LocationID string,
StratificationCategory1 string,
Stratification1 string,
StratificationCategoryId1 string,
StratificationID1 string )
row format serde 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
stored as textfile
location '<hdfs_location>/NutritionData/Nutrition_Physical_Activity/'
tblproperties ("skip.header.line.count"="1");


--4. Develop scripts/programs to calculate the following using Spark, and store the results into separate Hive tables:

--A) create below table where output will be saved

create table NutritionData.datavalue_byage (
Question string,
yearstart string,
age_in_months string,
avg_data_value string);

--B)
create table NutritionData.datavalue_bygender(
Question string,
yearstart string,
avg_data_value string);