#!/bin/bash
#set -e

#功能：
#多线程执行程序，可以设置测试节点的每个测试用例的测试结果（标记：初值->1,成功->0）
#最终目的是便于之后为在前端展示测试用例的执行结果而做的结果文件

if [ $# -ne 2 ];then
 echo "usage: $0 TestType Platform" 
 exit 1
fi

TestType="$1"
Platform="$2"
#----------------------------------------------------------------------------------------
#TestType="OS"
#Platform="7A_Integrated"
#----------------------------------------------------------------------------------------
ResultPath='/data'
ResultFile="TestResults_new.ini"
IniDir="TestIniDir"
srcIniPath="${ResultPath}/${TestType}/${Platform}/${IniDir}"
destPath="${ResultPath}/${TestType}/${Platform}"
destFile="${destPath}/${ResultFile}"
#----------------------------------------------------------------------------------------
outputDir=TestMark_CreateExcel
outputFile="${outputDir}/TestMark_${TestType}_${Platform}.txt"
ScoreListFile="ScoreCaseList/ScoreCaseList_${TestType}.txt"
#----------------------------------------------------------------------------------------
Log_Dir='Log_MakeExcel'
okfile=${Log_Dir}/ok_file.txt
errfile=${Log_Dir}/err_file.txt
#----------------------------------------------------------------------------------------


if [ ! -s $ScoreListFile ]
then
  echo "File $ScoreListFile is not Existed!"
  exit 1
fi

mkdir ${Log_Dir} -p
rm -rf ${okfile}
rm -rf ${errfile}

mkdir $outputDir -p
rm -rf $outputFile

:> ${okfile}
:> ${errfile}

echo "Creating the Results Score Excel files Begin..."

echo "***************************************************"
rm -rf $outputFile

start_time=`date +%s`              #定义脚本运行的开始时间

case_count=0
for line in `cat ${ScoreListFile}`
do
{
  case_name=$line
  echo "当前测试用例:$case_name" |tee -a ${outputFile}
  sh create_Excel_Points_all.sh $TestType $Platform "${case_name}"
}
done

echo "***************************************************"
stop_time=`date +%s`  #定义脚本运行的结束时间

echo "Exec Time:`expr $stop_time - $start_time`s"


echo "Creating the Results Score Excel files finished."
