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
Log_Dir='Log_MakeIni'
okfile=${Log_Dir}/ok_file.txt
errfile=${Log_Dir}/err_file.txt
#----------------------------------------------------------------------------------------

if [ ! -s $ScoreListFile ]
then
  echo "File $ScoreListFile is not Existed!"
  exit 1
fi

mkdir $outputDir -p
rm -rf $outputFile

mkdir $Log_Dir -p
rm -rf $okfile
rm -rf $errfile

:> ${okfile}
:> ${errfile}


echo "Making the Results ini files Begin..."

echo "***************************************************"
rm -rf $outputFile

start_time=`date +%s`              #定义脚本运行的开始时间
[ -e /tmp/fd1 ] || mkfifo /tmp/fd1 #创建有名管道
exec 3<>/tmp/fd1                   #创建文件描述符，以可读（<）可写（>）的方式关联管道文件，此时文件描述符3就有了有名管道文件的所有特性
rm -rf /tmp/fd1                    #关联后的文件描述符拥有管道文件的所有特性,因此这时管道文件可以删除，留下文件描述符使用即可
for ((i=1;i<=10;i++))
do
        echo >&3                   #&3代表引用文件描述符3，这条命令代表往管道里面放入了一个"令牌"
done


case_count=0
for line in `cat ${ScoreListFile}`
do
read -u3                           #代表从管道中读取一个令牌
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
  echo >&3                         #本次命令执行到最后，把令牌放回管道
}&
done
wait

echo "***************************************************"
stop_time=`date +%s`  #定义脚本运行的结束时间

echo "Exec Time:`expr $stop_time - $start_time`s"
exec 3<&-                         #关闭文件描述符的读
exec 3>&-                         #关闭文件描述符的写

pwd

echo "Making the Results ini files success."
