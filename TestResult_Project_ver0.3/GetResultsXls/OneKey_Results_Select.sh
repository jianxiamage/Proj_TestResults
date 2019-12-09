#!/bin/bash

if [ $# -ne 2 ];then
 echo "usage: $0 TestType Platform" 
 exit 1
fi
#---------------------------------------------
TestType=$1
Platform=$2
#---------------------------------------------

start_time=`date +%s`              #定义脚本运行的开始时间

echo "Begin to download result files.TestType:[$TestType],TestPlat:[$Platform]"
sh Grab_ResultFile_Select.sh $TestType $Platform

echo "Begin to make result files by ini format.TestType:[$TestType],TestPlat:[$Platform]"
sh Make_Result_Ini_Select.sh $TestType $Platform

echo "Begin to create Performance test run points files by Excel.TestType:[$TestType],TestPlat:[$Platform]"
sh Create_Result_Excel_Select.sh $TestType $Platform

echo "Begin to merge Performance test run points files by Excel for each test case.TestType:[$TestType],TestPlat:[$Platform]"
sh Merge_Excel_Select.sh $TestType $Platform

echo "Begin to summary Performance test run points files by Excel for all the performance test cases.TestType:[$TestType],TestPlat:[$Platform]"
sh Summary_Excel_Select.sh $TestType $Platform

stop_time=`date +%s`  #定义脚本运行的结束时间

echo "******************************************************"
echo "Exec Time:`expr $stop_time - $start_time`s"
echo "******************************************************"

echo "All performance score files created,Please check it."
