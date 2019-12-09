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
resultsPath=$(cat result_path.txt)
PointsPath='Points_Files'
Node_count=0
#----------------------------------------------------------------------------------------
#测试结果目录(筛选内容后)地址
detailDir="Detail"
destResultPath="${resultsPath}/${TestType}/${Platform}/${detailDir}/${TestCase}/${PointsPath}"


if [ ! -s $destResultPath ];
then
  echo Error! [$destResultPath] not existed!Please check it!
  exit 1
fi

echo -------------------------------------------------------------

ls $destResultPath/ | grep "${TestCase}" |grep "ini"

if [ $? -ne 0 ];
then
  echo "No ini files for $TestCase exists!Please check it!"
  exit 1
fi

echo -------------------------------------------------------------


#----------------------------UnixBench 单线程----------------------------------------
ls $destResultPath/ | grep "${TestCase}" |grep "ini" | grep "_1_" | grep "BASELINE"

if [ $? -eq 0 ];
then
  echo "Begin to create Excel file for UnixBench 1 thread,[BASELINE]..."
  sh create_Excel_Points_UnixBench_1thread_BASELINE.sh $TestType $Platform $TestCase
fi

ls $destResultPath/ | grep "${TestCase}" |grep "ini" | grep "_1_" | grep "RESULT"

if [ $? -eq 0 ];
then
  echo "Begin to create Excel file for UnixBench 1 thread,[RESULT]..."
  sh create_Excel_Points_UnixBench_1thread_RESULT.sh $TestType $Platform $TestCase
fi

ls $destResultPath/ | grep "${TestCase}" |grep "ini" | grep "_1_" | grep "INDEX"

if [ $? -eq 0 ];
then
  echo "Begin to create Excel file for UnixBench 1 thread,[INDEX]..."
  sh create_Excel_Points_UnixBench_1thread_INDEX.sh $TestType $Platform $TestCase
fi


#----------------------------UnixBench 2线程----------------------------------------
ls $destResultPath/ | grep "${TestCase}" |grep "ini" | grep "_2_" | grep "BASELINE"

if [ $? -eq 0 ];
then
  echo "Begin to create Excel file for UnixBench 2 threads,[BASELINE]..."
  sh create_Excel_Points_UnixBench_2thread_BASELINE.sh $TestType $Platform $TestCase
fi

ls $destResultPath/ | grep "${TestCase}" |grep "ini" | grep "_2_" | grep "RESULT"

if [ $? -eq 0 ];
then
  echo "Begin to create Excel file for UnixBench 2 threads,[RESULT]..."
  sh create_Excel_Points_UnixBench_2thread_RESULT.sh $TestType $Platform $TestCase
fi

ls $destResultPath/ | grep "${TestCase}" |grep "ini" | grep "_2_" | grep "INDEX"

if [ $? -eq 0 ];
then
  echo "Begin to create Excel file for UnixBench 2 thread,[INDEX]..."
  sh create_Excel_Points_UnixBench_2thread_INDEX.sh $TestType $Platform $TestCase
fi

#----------------------------UnixBench 4线程----------------------------------------
ls $destResultPath/ | grep "${TestCase}" |grep "ini" | grep "_4_" | grep "BASELINE"

if [ $? -eq 0 ];
then
  echo "Begin to create Excel file for UnixBench 4 threads,[BASELINE]..."
  sh create_Excel_Points_UnixBench_4thread_BASELINE.sh $TestType $Platform $TestCase
fi

ls $destResultPath/ | grep "${TestCase}" |grep "ini" | grep "_4_" | grep "RESULT"

if [ $? -eq 0 ];
then
  echo "Begin to create Excel file for UnixBench 4 threads,[RESULT]..."
  sh create_Excel_Points_UnixBench_4thread_RESULT.sh $TestType $Platform $TestCase
fi

ls $destResultPath/ | grep "${TestCase}" |grep "ini" | grep "_4_" | grep "INDEX"

if [ $? -eq 0 ];
then
  echo "Begin to create Excel file for UnixBench 4 threads,[INDEX]..."
  sh create_Excel_Points_UnixBench_4thread_INDEX.sh $TestType $Platform $TestCase
fi

#----------------------------UnixBench 8线程----------------------------------------
ls $destResultPath/ | grep "${TestCase}" |grep "ini" | grep "_8_" | grep "BASELINE"

if [ $? -eq 0 ];
then
  echo "Begin to create Excel file for UnixBench 8 threads,[BASELINE]..."
  sh create_Excel_Points_UnixBench_8thread_BASELINE.sh $TestType $Platform $TestCase
fi

ls $destResultPath/ | grep "${TestCase}" |grep "ini" | grep "_8_" | grep "RESULT"

if [ $? -eq 0 ];
then
  echo "Begin to create Excel file for UnixBench 8 threads,[RESULT]..."
  sh create_Excel_Points_UnixBench_8thread_RESULT.sh $TestType $Platform $TestCase
fi

ls $destResultPath/ | grep "${TestCase}" |grep "ini" | grep "_8_" | grep "INDEX"

if [ $? -eq 0 ];
then
  echo "Begin to create Excel file for UnixBench 8 threads,[INDEX]..."
  sh create_Excel_Points_UnixBench_8thread_INDEX.sh $TestType $Platform $TestCase
fi

#----------------------------UnixBench 16线程----------------------------------------
ls $destResultPath/ | grep "${TestCase}" |grep "ini" | grep "_16_" | grep "BASELINE"

if [ $? -eq 0 ];
then
  echo "Begin to create Excel file for UnixBench 16 threads,[BASELINE]..."
  sh create_Excel_Points_UnixBench_16thread_BASELINE.sh $TestType $Platform $TestCase
fi

ls $destResultPath/ | grep "${TestCase}" |grep "ini" | grep "_16_" | grep "RESULT"

if [ $? -eq 0 ];
then
  echo "Begin to create Excel file for UnixBench 16 threads,[RESULT]..."
  sh create_Excel_Points_UnixBench_16thread_RESULT.sh $TestType $Platform $TestCase
fi

ls $destResultPath/ | grep "${TestCase}" |grep "ini" | grep "_16_" | grep "INDEX"

if [ $? -eq 0 ];
then
  echo "Begin to create Excel file for UnixBench 16 threads,[INDEX]..."
  sh create_Excel_Points_UnixBench_16thread_INDEX.sh $TestType $Platform $TestCase
fi

