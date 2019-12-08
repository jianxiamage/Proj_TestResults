#!/bin/bash
set -e

#if [ $# -ne 3 ];then
# echo "usage: $0 TestType Platform TestCase" 
# exit 1
#fi

#----------------------------------------------------------------------------------------
TestType="OS"
Platform="7A_Integrated"
#----------------------------------------------------------------------------------------

echo "开始获取测试信息文件:[$TestType],[$Platform]"

echo "***************************************************"

rm -rf TestCase_Count.txt

case_count=0
for line in `cat ../Init_Env/TestCaseList.txt`
do
{
  case_name=$line
  echo "当前测试用例:$case_name" |tee -a TestCase_Count.txt
  sh get_OSInfo.sh $TestType $Platform "${case_name}"
}&
done
wait

echo "***************************************************"

