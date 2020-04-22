#!/bin/bash

########################################
#脚本功能:
#用于一键自动生成性能跑分Excel文件
########################################

#---------------------------------------------
#判断输入参数个数
#---------------------------------------------
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
pushd Grab_Results
sh Grab_ResultFile_Multi_Select.sh $TestType $Platform
popd

echo "Begin to make result files by ini format.TestType:[$TestType],TestPlat:[$Platform]"
pushd Make_Point_Files
sh Make_Result_Ini_Multi_Select.sh $TestType $Platform
popd

echo "Begin to create Performance test run points files by Excel.TestType:[$TestType],TestPlat:[$Platform]"
pushd Make_Excel_Files
sh Create_Result_Excel_Multi_Select.sh $TestType $Platform
popd

echo "Begin to merge Performance test run points files by Excel for each test case.TestType:[$TestType],TestPlat:[$Platform]"
pushd Excel_Merge_Proj
sh Merge_Excel_Multi_Select.sh $TestType $Platform
popd

echo "Begin to summary Performance test run points files by Excel for all the performance test cases.TestType:[$TestType],TestPlat:[$Platform]"
pushd Excel_Summary_Proj
sh Summary_Excel_Select.sh $TestType $Platform
popd

stop_time=`date +%s`  #定义脚本运行的结束时间

echo "******************************************************"
echo "Exec Time:`expr $stop_time - $start_time`s"
echo "******************************************************"

echo "All performance score files created,Please check it."
