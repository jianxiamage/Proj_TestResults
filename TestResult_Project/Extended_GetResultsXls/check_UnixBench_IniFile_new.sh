#!/bin/bash

#----------------------------------------------------------------------------------------

if [ $# -ne 2 ];then
 echo "usage: $0 TestType Platform" 
 exit 1
fi

#----------------------------------------------------------------------------------------
TestType="$1"
Platform="$2"
TestCase="UnixBench"
#TestMode="1thread"
#----------------------------------------------------------------------------------------
resultsPath=$(cat data_path.txt)
PointsPath='Points_Files'
Node_count=0
#----------------------------------------------------------------------------------------
#测试结果目录(筛选内容后)地址
destResultPath="${resultsPath}/${TestType}/${Platform}/$TestCase/$PointsPath"

#测试结果配置文件地址
#destIniPath="${resultsPath}/${TestType}/${Platform}/$TestCase/$PointsPath/${TestCase}_${Node_count}.ini"


if [ ! -s $destResultPath ];
then
  echo Error! [$destResultPath] not existed!Please check it!
  exit 1
fi

#if [ ! -s $destIniPath ];
#then
#  echo Error! [$destIniPath] not existed!Please check it!
#  exit 1
#fi

echo -------------------------------------------------------------

ls $destResultPath/ | grep "${TestCase}" |grep "ini"

if [ $? -ne 0 ];
then
  echo "No ini files for $TestCase exists!Please check it!"
  exit 1
fi

echo -------------------------------------------------------------


ls $destResultPath/ | grep "${TestCase}" |grep "ini" | grep "_1_" | grep "BASELINE"

if [ $? -eq 0 ];
then
  echo "Begin to create Excel file for UnixBench 1 thread..."
  sh create_Excel_Points_UnixBench_1thread_BASELINE.sh $TestType $Platform $TestCase
fi

ls $destResultPath/ | grep "${TestCase}" |grep "ini" | grep "_1_" | grep "RESULT"

if [ $? -eq 0 ];
then
  echo "Begin to create Excel file for UnixBench 1 thread..."
  sh create_Excel_Points_UnixBench_1thread_RESULT.sh $TestType $Platform $TestCase
fi

ls $destResultPath/ | grep "${TestCase}" |grep "ini" | grep "_1_" | grep "INDEX"

if [ $? -eq 0 ];
then
  echo "Begin to create Excel file for UnixBench 1 thread..."
  sh create_Excel_Points_UnixBench_1thread_INDEX.sh $TestType $Platform $TestCase
fi


