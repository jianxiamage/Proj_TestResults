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


ls $destResultPath/ | grep "${TestCase}" |grep "ini" |grep "1thread"

if [ $? -eq 0 ];
then
  echo "Begin to create Excel file for UnixBench 1 thread..."
  sh get_score_2config_UnixBench_1thread.sh $TestType $Platform $TestCase
fi

ls $destResultPath/ | grep "${TestCase}" |grep "ini" |grep "2thread"

if [ $? -eq 0 ];
then
  echo "Begin to create Excel file for UnixBench 2 threads..."
  sh get_score_2config_UnixBench_2thread.sh $TestType $Platform $TestCase
fi

ls $destResultPath/ | grep "${TestCase}" |grep "ini" |grep "4thread"

if [ $? -eq 0 ];
then
  echo "Begin to create Excel file for UnixBench 4 threads..."
  sh get_score_2config_UnixBench_4thread.sh $TestType $Platform $TestCase
fi

ls $destResultPath/ | grep "${TestCase}" |grep "ini" |grep "8thread"

if [ $? -eq 0 ];
then
  echo "Begin to create Excel file for UnixBench 8 threads..."
  sh get_score_2config_UnixBench_8thread.sh $TestType $Platform $TestCase
fi


ls $destResultPath/ | grep "${TestCase}" |grep "ini" |grep "16thread"

if [ $? -eq 0 ];
then
  echo "Begin to create Excel file for UnixBench 16 threads..."
  sh get_score_2config_UnixBench_16thread.sh $TestType $Platform $TestCase
fi

