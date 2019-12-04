#!/bin/bash
#set -e

#功能：
#多线程执行程序，可以设置测试节点的每个测试用例的测试结果（标记：初值->1,成功->0）
#最终目的是便于之后为在前端展示测试用例的执行结果而做的结果文件

if [ $# -ne 2 ];then
 echo "usage: $0 TestType Platform" 
 exit 1
fi

#----------------------------------------------------------------------------------------
TestType="$1"
Platform="$2"
#----------------------------------------------------------------------------------------
#TestType="OS"
#Platform="7A_Integrated"
#----------------------------------------------------------------------------------------
ResultPath='/data'
destPath="${ResultPath}/${TestType}/${Platform}"
destFile="${destPath}/${ResultFile}"
#----------------------------------------------------------------------------------------
outputDir=TestMark_SummaryExcel
outputFile="${outputDir}/TestMark_${TestType}_${Platform}.txt"
ScoreListFile="ScoreCaseList/ScoreCaseList_${TestType}.txt"
#----------------------------------------------------------------------------------------
merge_excelDir='Excel_Merge'
okfile="${merge_excelDir}/ok_file.txt"
errfile="${merge_excelDir}/err_file.txt"
#----------------------------------------------------------------------------------------

if [ ! -s $ScoreListFile ]
then
  echo "File $ScoreListFile is not Existed!"
  exit 1
fi

mkdir $outputDir -p
rm -rf $outputFile

mkdir ${merge_excelDir} -p
rm -rf $okfile
rm -rf $errfile

:> ${okfile}
:> ${errfile}

echo "[$TestType],[$Platform],Merging(Summary) the the Results Excel file finished."

echo "***************************************************"
rm -rf $outputFile

start_time=`date +%s`              #定义脚本运行的开始时间

sh summary_Excel_Results_all.sh $TestType $Platform

stop_time=`date +%s`  #定义脚本运行的结束时间

echo "Exec Time:`expr $stop_time - $start_time`s"

echo "***************************************************"
echo "[$TestType],[$Platform],Merging(Summary) the the Results Excel file finished."
