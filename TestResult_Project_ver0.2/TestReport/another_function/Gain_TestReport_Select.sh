#!/bin/bash

if [ $# -ne 2 ];then
 echo "usage: $0 TestType Platform" 
 exit 1
fi
#------------------------------------------------------
TestType=$1
Platform=$2
#------------------------------------------------------

start_time=`date +%s`              #定义脚本运行的开始时间

echo "Begin to get result report.TestType:[$TestType],TestPlat:[$Platform]"
Gain_TestReport="Gain_TestReport_${TestType}_${Platform}"
sh ${Gain_TestReport}.sh

stop_time=`date +%s`  #定义脚本运行的结束时间

echo "**********************************************"
echo "Exec Time:`expr $stop_time - $start_time`s"
echo "**********************************************"
