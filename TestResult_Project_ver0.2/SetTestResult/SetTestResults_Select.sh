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
srcIniPath="${ResultPath}/${TestType}/${Platform}/${IniDir}"
destPath="${ResultPath}/${TestType}/${Platform}"
destFile="${destPath}/${ResultFile}"
#----------------------------------------------------------------------------------------
outputDir=TestMark
outputFile="${outputDir}/TestMark_${TestType}_${Platform}.txt"
TestListFile="TestCaseList/TestCaseList_${TestType}.txt"
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

case_count=0
for line in `cat ${TestListFile}`
do
{
  case_name=$line
  echo "当前测试用例:$case_name" |tee -a ${outputFile}
  sh set_result_tag.sh $TestType $Platform "${case_name}"
}
done

echo "***************************************************"

pwd

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

echo "Setting the Results file success."
