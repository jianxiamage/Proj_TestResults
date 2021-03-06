#!/bin/bash
#set -e

#功能：
#单线程执行指定测试类型和测试平台下的测试信息文件(测试开始时间)下载
#最终目的是在每个测试用例的指定目录下生成相应的测试开始时间
#从而便于在前端页面查看每个测试用例对应的测试开始时间

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
outputDir=TestMark
outputFile="${outputDir}/TestMark_${TestType}_${Platform}.txt"
TestListFile="../Init_Env/TestCaseList/TestCaseList_${TestType}.txt"
#----------------------------------------------------------------------------------------

if [ ! -s $TestListFile ]
then
  echo "File $TestListFile is not Existed!"
  exit 1
fi

mkdir $outputDir -p
rm -rf $outputFile

echo "开始获取测试节点系统信息:[$TestType],[$Platform]"

echo "***************************************************"
rm -rf $outputFile

case_count=0
for line in `cat ${TestListFile}`
do
{
  case_name=$line
  echo "当前测试用例:$case_name" |tee -a ${outputFile}
  sh get_TestInfo.sh $TestType $Platform "${case_name}"
}
done

echo "***************************************************"
