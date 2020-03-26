#!/bin/bash

#-------------------------------------------------
#脚本功能:收集测试结果，最终形成html表格在前端展示
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
OSInfo_Dir="./Common_Func/OSInfo_Server"
#-------------------------------------------------
logFile="Collection_${TestType}_${Platform}.log"
#-------------------------------------------------
#设置环境变量，防止定时任务调用时出错
#. /etc/profile
#. ~/.bash_profile
source /etc/profile
#-------------------------------------------------
source ./Common_Func/create_LogFile.sh $logFile
#-------------------------------------------------

#-------------------------------------------------


start_time=`date +%s`              #定义脚本运行的开始时间

cmdStr="To collect Test Results Begin.-------------------------------"
echo $cmdStr
write_log "INFO" "${cmdStr}"

#获取测试节点的系统信息
#例如:系统类型，系统版本，内核版本
#由于系统信息会在测试开始不久后就上传到服务器上，理论上只需执行一次即可
#这里是每次收集结果都执行一次，因为任务开启时间不好界定
echo "*********************************************************"
cmdStr="Begin to get OS Info..."
echo $cmdStr
write_log "INFO" "${cmdStr}"
pushd Get_OSInfo_Server
sh GetOSInfo_Multi_Select.sh ${TestType} ${Platform}
popd
cmdStr="Getting OS Info End."
echo $cmdStr
write_log "INFO" "${cmdStr}"


#获取测试节点的测试信息
#获取测试开始时间
echo "*********************************************************"
cmdStr="Begin to get Test Info(Test Beginning Time)..."
echo $cmdStr
write_log "INFO" "${cmdStr}"
pushd TestInfo
sh GetTestInfo_Multi_Select.sh ${TestType} ${Platform}
popd
cmdStr="Get Test Info(Test Beginning Time) End."
echo $cmdStr
write_log "INFO" "${cmdStr}"

#获取测试节点详情(在线状态及日志)
echo "*********************************************************"
cmdStr="Begin to get Test Detail Info(OnLine or OffLine,and Log Info)..."
echo $cmdStr
write_log "INFO" "${cmdStr}"
pushd Get_LogInfo
sh Get_LogInfo_Multi_Select.sh ${TestType} ${Platform}
popd
cmdStr="Get Test Detail Info(OnLine or OffLine,and Log Info) End."
echo $cmdStr
write_log "INFO" "${cmdStr}"

#===============================================================
#查看是否所有的机器都已连接不上，则不再收集结果
echo "*********************************************************"
cmdStr="Begin to check the node state..."
echo $cmdStr
write_log "INFO" "${cmdStr}"
pushd ${OSInfo_Dir}
sh check_NodeState.sh ${TestType} ${Platform}
if [ $? -ne 0 ];
then
  cmdStr="All the test nodes are DOWN!EXIT..."
  echo $cmdStr
  write_log "ERROR" "${cmdStr}"
  exit 1
fi
popd
cmdStr="Checking the node state End."
echo $cmdStr
write_log "INFO" "${cmdStr}"
echo "*********************************************************"

#===============================================================

#设置测试结果标记(初始值:1,成功:0)
echo "*********************************************************"
cmdStr="Begin to set Test Result Tag..."
echo $cmdStr
write_log "INFO" "${cmdStr}"
pushd SetTestResult
sh SetTestResults_Multi_Select.sh ${TestType} ${Platform}
popd
cmdStr="set Test Result Tag End."
echo $cmdStr
write_log "INFO" "${cmdStr}"
echo "*********************************************************"

#测试结果反馈到前端展示页面
echo "*********************************************************"
cmdStr="Begin to make Test TestReport..."
echo $cmdStr
write_log "INFO" "${cmdStr}"
pushd TestReport
sh Gain_TestReport_Select.sh ${TestType} ${Platform}
popd
cmdStr="Make Test TestReport End."
echo $cmdStr
write_log "INFO" "${cmdStr}"
echo "*********************************************************"

#性能测试跑分详细写在Excel中
echo "*********************************************************"
cmdStr="Begin to make Points Files for Performance Test Cases..."
echo $cmdStr
write_log "INFO" "${cmdStr}"
pushd GetResultsXls
sh OneKey_Results_Multi_Select.sh ${TestType} ${Platform}
popd
cmdStr="Make Points Files for Performance Test Cases End."
echo $cmdStr
write_log "INFO" "${cmdStr}"
echo "*********************************************************"

#每次收集结果都备份当前测试的情况
echo "*********************************************************"
cmdStr="Begin to Backup The Test Results..."
echo $cmdStr
write_log "INFO" "${cmdStr}"
pushd Backup_Tool

sh BackUp_History.sh ${TestType} ${Platform}
if [ $? -ne 0 ];
then
  echo "Backup History failed!exit..." 
  exit 1
fi

popd

cmdStr="Backup The Test Results End."
echo $cmdStr
write_log "INFO" "${cmdStr}"
echo "*********************************************************"

#将收集结果按照PC,Server,KVM的形式进行分类
echo "*********************************************************"
cmdStr="Begin to Classify The Test Results..."
echo $cmdStr
write_log "INFO" "${cmdStr}"

pushd Classify_Results

sh Classify_Test.sh ${TestType} ${Platform}
if [ $? -ne 0 ];
then
  cmdStr="Classify the test results failed!exit..."
  echo $cmdStr
  write_log "ERROR" "${cmdStr}"
  exit 1
fi

cmdStr="Begin to Backup The Test Results to Classify Path..."
echo $cmdStr
write_log "INFO" "${cmdStr}"

sh BackUpResults_History.sh ${TestType} ${Platform}
if [ $? -ne 0 ];
then
  cmdStr="Backup the classification test results failed!exit..."
  echo $cmdStr
  write_log "ERROR" "${cmdStr}"
  exit 1
fi

cmdStr="Backup The Test Results to Classify Path End."
echo $cmdStr
write_log "INFO" "${cmdStr}"

popd
echo "*********************************************************"
cmdStr="Classify The Test Results End."
echo $cmdStr
write_log "INFO" "${cmdStr}"

#数据库信息写入及备份
echo "*********************************************************"
cmdStr="Begin to write DB tables and to Backup..."
echo $cmdStr
write_log "INFO" "${cmdStr}"
pushd DataBase_Results
sh OneKey_DataBase_Multi_Select.sh ${TestType} ${Platform} 
popd
cmdStr="To write DB tables and to Backup End."
echo $cmdStr
write_log "INFO" "${cmdStr}"
echo "*********************************************************"


stop_time=`date +%s`  #定义脚本运行的结束时间

echo "***************************************************"
cmdStr="Exec Time:`expr $stop_time - $start_time`s"
echo $cmdStr
write_log "INFO" "${cmdStr}"
echo "***************************************************"

cmdStr="To collect Test Results End.--------------------------------"
echo $cmdStr
write_log "INFO" "${cmdStr}"

