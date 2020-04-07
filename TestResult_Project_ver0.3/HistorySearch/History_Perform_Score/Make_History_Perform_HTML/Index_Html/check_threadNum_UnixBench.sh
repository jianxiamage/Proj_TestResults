#!/bin/bash

#----------------------------------------------------------------------------------------
if [ $# -ne 3 ];then
 echo "usage: $0 TestType Platform class_type" 
 exit 1
fi
#----------------------------------------------------------------------------------------
TestType="$1"
Platform="$2"
class_type="$3"
TestCase="UnixBench"
#----------------------------------------------------------------------------------------
resultsPath='/data'
web_path='/Results'
PointsPath='Points_Files'
Node_count=0
#----------------------------------------------------------------------------------------
#测试结果目录(筛选内容后)地址
detailDir="Detail"
destPath="${resultsPath}/${TestType}/${Platform}/${detailDir}/${TestCase}/${PointsPath}"
pointPath="${web_path}/${class_type}/${Platform}/${TestType}/${detailDir}/${TestCase}/${PointsPath}"
thread_ListFile=$pointPath/thread_count.cfg
#----------------------------------------------------------------------------------------

echo "thread_ListFile=$thread_ListFile"

echo "-------------------------------------------------------------"
#----------------------------------------------------------------------------------------
#首先检查目标目录是否存在
if [ ! -s $destPath ];
then
  echo Error! [$destPath] not existed!Please check it!
  exit 1
fi

#----------------------------------------------------------------------------------------
#检查测试结果文件是否生成
ls $destPath/ | grep "${TestCase}" |grep "ini"

if [ $? -ne 0 ];
then
  echo "No ini files for $TestCase exists!Please check it!"
  exit 1
fi

echo "-------------------------------------------------------------"

#----------------------------------------------------------------------------------------
#判断是否存在相应的ini文件，从而判断线程数
rm -f $thread_ListFile
:> $thread_ListFile

num_th="1 2 4 8 16"
for i in $num_th;
do
  ls $destPath/ | grep "${TestCase}" |grep "ini" |grep "${i}thread"
  if [ $? -eq 0 ];
  then
    TestMode="UnixBench_${i}thread"
    echo $i >> $thread_ListFile
  fi
done
#----------------------------------------------------------------------------------------
if [ ! -s $thread_ListFile ]
then
  echo "No UnixBench files created,Maybe the test is not beginning."
  exit 1
fi
