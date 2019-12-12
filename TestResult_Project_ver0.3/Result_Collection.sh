#!/bin/bash

#-------------------------------------------------
#脚本功能:收集测试结果，最终形成html表格在前端展示
#-------------------------------------------------

#-------------------------------------------------
#设置环境变量，防止定时任务调用时出错
#. /etc/profile
#. ~/.bash_profile
source /etc/profile
#-------------------------------------------------


if [ $# -ne 2 ];then
 echo "usage: $0 TestType Platform" 
 exit 1
fi

#-------------------------------------------------
TestType="$1"
Platform="$2"
#-------------------------------------------------

start_time=`date +%s`              #定义脚本运行的开始时间

#获取测试节点的测试信息
#获取测试开始时间
echo "*********************************************************"
echo "Begin to get Test Info(Test Staring Time...)"
pushd TestInfo
sh GetTestInfo_Multi_Select.sh ${TestType} ${Platform}
popd
echo "Get Test Info(Test Staring Time...) End."

#设置测试结果标记(初始值:1,成功:0)
echo "*********************************************************"
echo "Begin to set Test Result Tag..."
pushd SetTestResult
sh SetTestResults_Multi_Select.sh ${TestType} ${Platform}
popd
echo "set Test Result Tag End."
echo "*********************************************************"

#测试结果反馈到前端展示页面
echo "*********************************************************"
echo "Begin to make Test TestReport..."
pushd TestReport
sh Gain_TestReport_Select.sh ${TestType} ${Platform}
popd
echo "Make Test TestReport End."
echo "*********************************************************"

#性能测试跑分详细写在Excel中
echo "*********************************************************"
echo "Begin to make Points Files..."
pushd GetResultsXls
sh OneKey_Results_Multi_Select.sh ${TestType} ${Platform}
popd
echo "Make Points Files End."
echo "*********************************************************"

#每次收集结果都备份当前测试的情况
echo "*********************************************************"
echo "Begin to Backup The Test Results..."
pushd Backup_Tool

sh BackUp_History.sh ${TestType} ${Platform}
if [ $? -ne 0 ];
then
  echo "Backup History failed!exit..." 
  exit 1
fi

popd
echo "Backup The Test Results End."
echo "*********************************************************"

#将收集结果按照PC,Server,KVM的形式进行分类
echo "*********************************************************"
echo "Begin to Classify The Test Results..."
pushd Classify_Results

sh Classify_Test.sh ${TestType} ${Platform}
if [ $? -ne 0 ];
then
  echo "Classify the test results failed!exit..." 
  exit 1
fi

echo "Begin to Backup The Test Results to Classify Path..."

sh BackUpResults_History.sh ${TestType} ${Platform}
if [ $? -ne 0 ];
then
  echo "Backup the classification test results failed!exit..." 
  exit 1
fi

echo "Backup The Test Results to Classify Path End."

popd
echo "*********************************************************"
echo "Classify The Test Results End."

stop_time=`date +%s`  #定义脚本运行的结束时间

echo "***************************************************"
echo "Exec Time:`expr $stop_time - $start_time`s"
echo "***************************************************"
