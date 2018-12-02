# MSDNutrition

# Interview Assignment 

To demonstrate skillset of ETL, Hive and Spark. Please develop automation pipeline to ingest and calculate data in BigData Platform. 

1. Setup Hadoop Stack (Ex. Use Scripts like - Ansible, Bash etc to setup Hadoop Stack or Download Hortonworks Sandbox).
2. Develop scripts/programs to download and ingest data from < https://chronicdata.cdc.gov/views/735e-byxc/rows.csv?accessType=DOWNLOAD>

to HDFS and Hive. 
3. Develop scripts/programs to calculate the following using Spark, and store the results into separate Hive tables:
- Average of each Question’s "Data_Value" by year for all age groups
- Average of each Question’s "Data_Value" by year for female only
4. Bonus (Optional) - Develop data visualization to show the data. (Ex. SpringBoot, React, JavaScript, HTML - D3.js)
5. Create a ***README.md*** file to include the execution steps to setup environment and run the solution.
6. Check-in the solution in GitHub.

#############################################################################################################################
Files attched in github:
1)MSDNutrition.rar -- contains full package that is required to implement two use cases.
2) 





Info:
The below code is tested on Hortonsandbox with Spark Version 1.6.3 and developed on Scala IDE (Scala IDE build of Eclipse SDK :: Build id: 4.7.0-vfinal-2017-09-29T14:34:02Z-Typesafe) and build using Maven,

Spark Version: 1.6.3
Spark-Sql: 1.6.3
Spark-core: 1.6.3

Assumptions Considered:

1) Downloaded the data file as is to windows machine and pushed to unix local server using winscp .
2) Above two use cases are considered as separate requirement.
3) I have considered the age(in months) as string column in the data feed.
4) age(in months) field had blank values in data provided, is considered as it is for calculations. 

Steps::

1) Login to unix sever using Putty and create the following directory to copy the data and use case related jar :

mkdir -p <home>/MSDNutrition [example: mkdir -p /home/shubham/MSDNutrition]
mkdir -p <home>/MSDNutrition/codejars [example: mkdir -p /home/shubham/MSDNutrition/codejars]
mkdir -p <home>/MSDNutrition/data [example: mkdir -p /home/shubham/MSDNutrition/data] 

######NOTE :: Once you download the files inside <home>/MSDNutrition , run below command first:####
cd  <home>/MSDNutrition
    find . -type f -print0 | xargs -0 dos2unix   ### this commmand will converrt the files in unix format.
    chmod -R 775 *

2) Download data and move to unix local system using WinSCP or we can also wget command to download the data directly (if no security enabled in unix server) 
On Unix server:
    cd <home>/MSDNutrition/data
    wget https://chronicdata.cdc.gov/views/735e-byxc/rows.csv?accessType=DOWNLOAD
 
    NOTE : If data copied through wget command , then the file name made to be used [hadoop fs -put] in command to push the data on hdfs location
    hadoop fs -put <filename> <hdfs_location>/NutritionData/Nutrition_Physical_Activity/
 
                                        OR
    Copy the data using winscp from windows machine under <home>/MSDNutrition/data and run below command to push the data on hdfs:

    a) hadoop fs -mkdir -p <hdfs_location>/NutritionData/Nutrition_Physical_Activity/
    b) hadoop fs -put -f <home>/MSDNutrition/data/input/Nutrition__Physical_Activity__and_Obesity_-_Women__Infant__and_Child.csv <hdfs_location>/NutritionData/Nutrition_Physical_Activity/ 

3) Download the file create_table.txt from github under <home>/MSDNutrition and run the below command through unix server

Note : Open the create_table.txt file and change the <hdfs_location> to your cluster HDFS location

hive -f "<home>/MSDNutrition/create_table.hql"
                OR

We can open the file and run command one by one command on hive.


4) Download and copy the following files using winscp (if files downloaded on windows machine) under <home>/MSDNutrition from github:
a) columnlist.txt ##Master column list of Nutrition data
b) nutridata.sh ##script to load and generate visualization dashboard
c) nutrition_byage_header.txt ## header file required for visualization dasboard
d) nutrition_bygender_header.txt ##header file required for visualization dashboard
e) nutrition_trailer.txt ## trailer file required for visualization dashboard

5) Download and Copy the code jars from github using winscp (if files downloaded on windows machine)to folder <home>/MSDNutrition/codejars. Filenames are below:

Note : Below jars are created, compiled and tested on Spark Version 1.6.3

a) datavaluebyage.jar
b) datavaluebygender.jar

###On Unix server
cd  <home>/MSDNutrition
    find . -type f -print0 | xargs -0 dos2unix
    chmod -R 775 *


6) I have tested the use cases using shell script which will create visual dashboard and sent as an email to recipient (Note: Mail client should be configured). If mail client is not configured . Please ignore this step:
NOTE : export below varible in .profile of application id :
1) cd ~ 
2) Open the .profile then add export HOMEPATH=<home> 
Example: vi .profile 
[Press Esc then i] 
export HOMEPATH=/home/shubham 
to save the content [Esc + :w +:q]	

##To excute the command through shell script
1)cd <home>/MSDNutrition/
2) sh nutridata.sh <age/gender> [example : sh nutridata.sh age ]

7) Command to excute the use cases separately:
## Command for UseCase 1: Average of each Question’s "Data_Value" by year for all age groups##
spark-submit --class nutritionbygender.datavaluebyage <home>/MSDNutrition/codejars/datavaluebyage.jar <home>/MSDNutrition/columnlist.txt

## Command for UseCase 2: Average of each Question’s "Data_Value" by year for female only ##
spark-submit --class nutritionbygender.datavaluebygender <home>/MSDNutrition/codejars/datavaluebygender.jar <home>/MSDNutrition/columnlist.txt

##################### Configure Maven for the project: ####################

1) Please refer attached msd_maven.doc and follow the steps 
  
##################Visuaization Dasboard Screenshot########################

1) Please refer attached msd_visualzation_dashboarad.doc

