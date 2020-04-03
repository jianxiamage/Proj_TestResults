#!/bin/bash

#功能：
#多线程执行指定测试类型和测试平台下的测试用例结果信息历史记录
#最终目的是在每个测试用例历史记录
#从而便于在前端页面查看每个测试用例对应的结果历史记录

#----------------------------------------------------------------------------------------
if [ $# -ne 2 ];then
 echo "usage: $0 TestType Platform" 
 exit 1
fi
#----------------------------------------------------------------------------------------

#----------------------------------------------------------------------------------------
TestType="$1"
Platform="$2"
#----------------------------------------------------------------------------------------
outputDir=TestMark
outputFile="${outputDir}/TestMark_${TestType}_${Platform}.txt"
TestListFile="../../../Init_Env/TestCaseList/TestCaseList_${TestType}.txt"
#----------------------------------------------------------------------------------------

if [ ! -s $TestListFile ]
then
  echo "File $TestListFile is not Existed!"
  exit 1
fi

#----------------------------------------------------------------------------
class_type=`sh ../../Common/grab_TestTag.sh $TestType $Platform "ClassifyType"`
echo "class_type:$class_type"
#----------------------------------------------------------------------------

rm -rf $outputDir
mkdir $outputDir -p

sh mark_DirList_History_Results.sh $TestType $Platform
if [ $? -ne 0 ]
then
  echo "Error!Writing test results history dir list failed."
  exit 1
fi


echo "Begin to get the test results history of the test nodes:[${TestType}],[${Platform}]..."

echo "***************************************************"
rm -rf $outputFile

start_time=`date +%s`              #定义脚本运行的开始时间

case_count=0
for line in `cat ${TestListFile}`
do
{
  case_name=$line
  echo "当前测试用例:$case_name" |tee -a ${outputFile}
  sh get_ResultHistory.sh $TestType $Platform $class_type "${case_name}"
}
done
wait

echo "***************************************************"
stop_time=`date +%s`  #定义脚本运行的结束时间

echo "***************************************************"
echo "Exec Time:`expr $stop_time - $start_time`s"
echo "***************************************************"

echo "get the test results history of the test nodes End.:[${TestType}],[${Platform}]"
