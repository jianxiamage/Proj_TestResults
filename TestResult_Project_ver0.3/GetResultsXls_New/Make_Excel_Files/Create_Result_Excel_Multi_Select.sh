#!/bin/bash

##################################################################################
#功能：
#多线程执行程序，可以设置测试节点的每个测试用例的测试结果（标记：初值->1,成功->0）
#最终目的是便于之后为在前端展示测试用例的执行结果而做的结果文件
##################################################################################

#--------------------------------------
#判断输入参数个数
#--------------------------------------
if [ $# -ne 2 ];then
 echo "usage: $0 TestType Platform" 
 exit 1
fi

#--------------------------------------
TestType="$1"
Platform="$2"
#----------------------------------------------------------------------------------------
#变量初始化
#----------------------------------------------------------------------------------------
ResultPath='/data'
ResultFile="TestResults_new.ini"
IniDir="TestIniDir"
srcIniPath="${ResultPath}/${TestType}/${Platform}/${IniDir}"
destPath="${ResultPath}/${TestType}/${Platform}"
destFile="${destPath}/${ResultFile}"
#----------------------------------------------------------------------------------------
outputDir=TestMark_MakeExcel
outputFile="${outputDir}/TestMark_${TestType}_${Platform}.txt"
ScoreCaseListFile="../ScoreCaseList/ScoreCaseList_${TestType}.txt"
#----------------------------------------------------------------------------------------
Log_Dir='Log_MakeExcel'
okfile=${Log_Dir}/ok_file.txt
errfile=${Log_Dir}/err_file.txt
#----------------------------------------------------------------------------------------


if [ ! -s $ScoreCaseListFile ]
then
  echo "File $ScoreCaseListFile is not Existed!"
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
[ -e /tmp/fd1 ] || mkfifo /tmp/fd1 #创建有名管道
exec 3<>/tmp/fd1                   #创建文件描述符，以可读（<）可写（>）的方式关联管道文件，此时文件描述符3就有了有名管道文件的所有特性
rm -rf /tmp/fd1                    #关联后的文件描述符拥有管道文件的所有特性,因此这时管道文件可以删除，留下文件描述符使用即可
for ((i=1;i<=5;i++))
do
        echo >&3                   #&3代表引用文件描述符3，这条命令代表往管道里面放入了一个"令牌"
done


case_count=0
for line in `cat ${ScoreCaseListFile}`
do
read -u3                           #代表从管道中读取一个令牌
{
  case_name=$line
  echo "当前测试用例:$case_name" |tee -a ${outputFile}
  sh create_Excel_Points_all.sh $TestType $Platform "${case_name}"
  echo >&3                         #本次命令执行到最后，把令牌放回管道
}&
done
wait

echo "***************************************************"
stop_time=`date +%s`  #定义脚本运行的结束时间

echo "Exec Time:`expr $stop_time - $start_time`s"
exec 3<&-                         #关闭文件描述符的读
exec 3>&-                         #关闭文件描述符的写


echo "Creating the Results Score Excel files finished."
