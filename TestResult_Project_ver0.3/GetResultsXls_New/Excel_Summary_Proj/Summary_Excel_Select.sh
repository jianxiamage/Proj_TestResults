#!/bin/bash

#######################################################################
#功能：
#多线程执行程序，可以将每种性能测试生成的跑分文件(Excel)合并为一个文件
#例如:7A双路在OS测试类型时,结果合并为一个Excel表格
#######################################################################

#-----------------------------------------------------------------
#判断输入参数
#-----------------------------------------------------------------
if [ $# -ne 2 ];then
 echo "usage: $0 TestType Platform" 
 exit 1
fi

#--------------------------------------------------------------
#变量初始化
#--------------------------------------------------------------
TestType="$1"
Platform="$2"
#--------------------------------------------------------------
ResultPath='/data'
destPath="${ResultPath}/${TestType}/${Platform}"
destFile="${destPath}/${ResultFile}"
#--------------------------------------------------------------
outputDir=TestMark_SummaryExcel
outputFile="${outputDir}/TestMark_${TestType}_${Platform}.txt"
ScoreListFile="../ScoreCaseList/ScoreCaseList_${TestType}.txt"
#--------------------------------------------------------------
Log_Dir='Log_SummaryExcel'
okfile="${Log_Dir}/ok_file.txt"
errfile="${Log_Dir}/err_file.txt"
#--------------------------------------------------------------

if [ ! -s $ScoreListFile ]
then
  echo "File $ScoreListFile is not Existed!"
  exit 1
fi

mkdir $outputDir -p
rm -rf $outputFile

mkdir ${Log_Dir} -p
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
