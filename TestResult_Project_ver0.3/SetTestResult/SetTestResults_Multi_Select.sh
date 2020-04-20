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
ResultFile="TestResults.ini"
IniDir="TestIniDir"
detailPath="Detail"
srcIniPath="${ResultPath}/${TestType}/${Platform}/${detailPath}/${IniDir}"
destPath="${ResultPath}/${TestType}/${Platform}"
destFile="${destPath}/${ResultFile}"
#----------------------------------------------------------------------------------------
outputDir=TestMark
outputFile="${outputDir}/TestMark_${TestType}_${Platform}.txt"
TestListFile="../Init_Env/TestCaseList/TestCaseList_${TestType}.txt"
#----------------------------------------------------------------------------------------
okfile='ok_file.txt'
errfile='err_file.txt'
#----------------------------------------------------------------------------------------

if [ ! -s $TestListFile ]
then
  echo "File $TestListFile is not Existed!"
  exit 1
fi

mkdir $outputDir -p
rm -rf $outputFile

:> ${okfile}
:> ${errfile}

echo "开始获取测试节点测试结果信息:[$TestType],[$Platform]"

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
for line in `cat ${TestListFile}`
do
read -u3                           #代表从管道中读取一个令牌
{
  case_name=$line
  echo "当前测试用例:$case_name" |tee -a ${outputFile}
  sh set_result_tag.sh $TestType $Platform "${case_name}"
  echo >&3                         #本次命令执行到最后，把令牌放回管道
}&
done
wait

echo "***************************************************"
stop_time=`date +%s`  #定义脚本运行的结束时间

echo "***************************************************"
echo "Exec Time:`expr $stop_time - $start_time`s"
echo "***************************************************"
exec 3<&-                         #关闭文件描述符的读
exec 3>&-                         #关闭文件描述符的写

echo "Merge the results ini file to 1 file..."
:> ${destFile} 

i=1
for filename in `cat ${TestListFile}`
do
  #echo "第[$i]个测试用例:$filename:"
  if [ -s "${srcIniPath}/${filename}.ini" ];
  then
    cat ${srcIniPath}/${filename}.ini >> ${destFile}
  else
    echo "Test Case ini file: ${filename}.ini Not exists!"
  fi
  let i++
done

success_count=$(cat ${okfile}|wc -l)
echo "**************************************************"
echo "The success count of the test case result is:[${success_count}]"
echo "**************************************************"
echo "Setting the Results file success."
