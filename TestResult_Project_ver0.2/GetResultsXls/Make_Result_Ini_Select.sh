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
destPath="${ResultPath}/${TestType}/${Platform}"
#----------------------------------------------------------------------------------------
outputDir=TestMark_MakeIni
outputFile="${outputDir}/TestMark_${TestType}_${Platform}.txt"
ScoreListFile="ScoreCaseList/ScoreCaseList_${TestType}.txt"
#----------------------------------------------------------------------------------------
okfile='ok_file.txt'
errfile='err_file.txt'
#----------------------------------------------------------------------------------------

if [ ! -s $ScoreListFile ]
then
  echo "File $ScoreListFile is not Existed!"
  exit 1
fi

mkdir $outputDir -p
rm -rf $outputFile

start_time=`date +%s`              #定义脚本运行的开始时间

:> ${okfile}
:> ${errfile}


echo "Making the Results ini files Begin..."

echo "***************************************************"
rm -rf $outputFile

case_count=0
for line in `cat ${ScoreListFile}`
do
{
  case_name=$line
  echo "当前测试用例:$case_name" |tee -a ${outputFile}
  sh make_Ini_Points_all.sh $TestType $Platform "${case_name}"
  if [ $? -eq 0 ];
  then
    echo "TestType:[${TestType}] Platform:[${Platform}] TestCase:[${case_name}] setting result file success!" >> $okfile
  else
    echo "TestType:[${TestType}] Platform:[${Platform}] TestCase:[${case_name}] setting result file failed!" >> $errfile
  fi
}
done

echo "***************************************************"
stop_time=`date +%s`  #定义脚本运行的结束时间

echo "Exec Time:`expr $stop_time - $start_time`s"

pwd

echo "Making the Results ini files success."
