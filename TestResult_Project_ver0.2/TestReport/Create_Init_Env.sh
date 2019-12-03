#!/bin/bash

if [ $# -ne 2 ];then
 echo "usage: $0 TestType Platform" 
 exit 1
fi
#------------------------------------------------------
TestType=$1
Platform=$2
#------------------------------------------------------
Std_TestReprotDir="TestReport_Dir"
TestReportDir="TestReport_${TestType}_${Platform}"
#------------------------------------------------------
StdTestFilePath=MakeTestFile
StdCaseFile=${StdTestFilePath}/Std_CaseList_${TestType}.txt
#------------------------------------------------------

start_time=`date +%s`              #定义脚本运行的开始时间

echo "Begin to create Test Report Dir.TestType:[$TestType],TestPlat:[$Platform]"

#mkdir $TestReportDir -p
\cp MakeTestPyFile/Std_CaseList_${TestType}.txt ./Std_CaseList.txt -f
\cp -draf ${Std_TestReprotDir} ${TestReportDir}

stop_time=`date +%s`  #定义脚本运行的结束时间

echo "Create Test Report Dir finished.TestType:[$TestType],TestPlat:[$Platform]"
echo "**********************************************"
echo "Exec Time:`expr $stop_time - $start_time`s"
echo "**********************************************"
