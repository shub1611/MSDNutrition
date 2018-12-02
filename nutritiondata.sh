#!/bin/sh

#Command to trigger the script 
# sh nutridata.sh <age/gender>

if [[ $# -gt 1 || $# -lt 1 ]]; then
echo "Error: Number of arguments are not correct for the script <nutridata.sh>"
exit 1
fi
. ${HOME}/.profile
nutritionCategory=$1
HTMLFILE="${HOMEPATH}/MSDNutrition/nutrition_by${nutritionCategory}.html"
HEADERFILE="${HOMEPATH}/MSDNutrition/nutrition_by${nutritionCategory}_header.txt"
TRAILERFILE="${HOMEPATH}/MSDNutrition/nutrition_trailer.txt"

##Run spark-submit command to load data in Case_1(Average of each Questionâ€™s "Data_Value" by year for all age groups) and Case_2(Average of each Questionâ€™s "Data_Value" by year for female only) 

spark-submit --class nutritionby${nutritionCategory}.datavalueby${nutritionCategory} ${HOMEPATH}/MSDNutrition/codejars/datavalueby${nutritionCategory}.jar ${HOMEPATH}/MSDNutrition/columnlist.txt
if [[ $? -eq 0 ]]; then
hive -S -e "select concat_ws(',',*) from nutritiondata.datavalue_by${nutritionCategory}" > ${HOMEPATH}/MSDNutrition/data/nutby${nutritionCategory}.txt
if [[ -f "${HOMEPATH}/MSDNutrition/data/nutby${nutritionCategory}.txt" ]]; then
cat ${HEADERFILE} > ${HTMLFILE}
sed "s/,/<\/td><td>/g" ${HOMEPATH}/MSDNutrition/data/nutby${nutritionCategory}.txt | while read line 
do 
printf "<tr><td>${line}</td></tr>\n" >> ${HTMLFILE} 
done

fi 
cat ${TRAILERFILE} >> ${HTMLFILE}

#else
# echo "Error: Issue in Connecting Hive or data not yet populated in case_1_datavalue_by${nutritionCategory} table"
# echo "exit 1"
# exit 1

( echo "To: IcddDev.Team@scbdev.com"; echo "cc: jyoti.vijay@sc.com,shubham.dwivedi@sc.com" ;echo "Subject: Nutrition Visualization Dashboard by ${nutritionCategory} "; echo "Content-Type: text/html"; echo "MIME-Version: 1.0"; echo "";cat ${HTMLFILE}; ) | /usr/sbin/sendmail -t

fi