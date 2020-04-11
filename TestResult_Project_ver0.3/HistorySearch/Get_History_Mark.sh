#!/bin/bash

#-------------------------------------------------
#脚本功能:测试结果历史记录查看功能
#-------------------------------------------------

#-------------------------------------------------
if [ $# -ne 2 ];then
  cmdStr="usage: $0 TestType Platform"
  echo $cmdStr
  exit 1
fi
#-------------------------------------------------

#-------------------------------------------------
TestType="$1"
Platform="$2"
#-------------------------------------------------
#OSInfo_Dir="./Common_Func/OSInfo_Server"
#-------------------------------------------------
logFile="History_${TestType}_${Platform}.log"
#-------------------------------------------------
#设置环境变量，防止定时任务调用时出错
#. /etc/profile
#. ~/.bash_profile
source /etc/profile
#-------------------------------------------------
source ../Common_Func/create_LogFile.sh $logFile
#-------------------------------------------------


start_time=`date +%s`              #定义脚本运行的开始时间

cmdStr="To get history mark of test results Begin.-------------------------------"
echo $cmdStr
write_log "INFO" "${cmdStr}"

echo "*********************************************************"
cmdStr="Begin to make history files(ini)..."
echo $cmdStr
write_log "INFO" "${cmdStr}"
pushd History_Case_Results/Make_History_Ini
sh GetCaseResult_Multi_Select.sh ${TestType} ${Platform}
popd
cmdStr="To make history files(ini) End."
echo $cmdStr
write_log "INFO" "${cmdStr}"
echo "*********************************************************"

echo "*********************************************************"
cmdStr="Begin to make history files(html)..."
echo $cmdStr
write_log "INFO" "${cmdStr}"
pushd History_Case_Results/Make_History_Html
sh Get_Html_CaseResult_Multi_Select.sh ${TestType} ${Platform}
popd
cmdStr="To make history files(html) End."
echo $cmdStr
write_log "INFO" "${cmdStr}"
echo "*********************************************************"

echo "*********************************************************"
cmdStr="Begin to make perform score history files(csv)..."
echo $cmdStr
write_log "INFO" "${cmdStr}"
pushd History_Perform_Score/Make_History_Perform_CSV
sh Make_history_2csv_Multi.sh ${TestType} ${Platform}
popd
cmdStr="To make perform score history files(csv) End."
echo $cmdStr
write_log "INFO" "${cmdStr}"
echo "*********************************************************"

echo "*********************************************************"
cmdStr="Begin to make perform score history files(html)..."
echo $cmdStr
write_log "INFO" "${cmdStr}"
pushd History_Perform_Score/Make_History_Perform_HTML
sh Make_history_2html_Multi.sh ${TestType} ${Platform}
popd
cmdStr="To make perform score history files(html) End."
echo $cmdStr
write_log "INFO" "${cmdStr}"
echo "*********************************************************"


stop_time=`date +%s`  #定义脚本运行的结束时间

echo "***************************************************"
cmdStr="Exec Time:`expr $stop_time - $start_time`s"
echo $cmdStr
write_log "INFO" "${cmdStr}"
echo "***************************************************"

cmdStr="To get history mark of test results End."
echo $cmdStr
write_log "INFO" "${cmdStr}"

