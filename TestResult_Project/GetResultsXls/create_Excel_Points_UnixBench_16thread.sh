#!/bin/bash

#----------------------------------------------------------------------------------------

if [ $# -ne 3 ];then
 echo "usage: $0 TestType Platform TestCase" 
 exit 1
fi

#----------------------------------------------------------------------------------------
TestType="$1"
Platform="$2"
TestCase="$3"
TestMode="16thread"
#----------------------------------------------------------------------------------------
resultsPath='/data'
PointsPath='Points_Files'
Node_count=0
#----------------------------------------------------------------------------------------
#测试结果文件(筛选内容后)地址
detailDir="Detail"
destResultPath="${resultsPath}/${TestType}/${Platform}/${detailDir}/${TestCase}/${PointsPath}"


if [ ! -s $destResultPath ];
then
  echo Error! [$destResultPath] not existed!Please check it!
  exit 1
fi

echo -------------------------------------------------------------

count_nodes=`cat node_count.cfg` || { echo "File:node_count.cfg is not existed!";exit 1;}

ls -l $destResultPath/${TestCase}_${TestMode}_*.ini 

if [ $? -ne 0 ];
then
  echo "No $TestMode files exists!Please check it!"
  exit 1
fi

Node_count=`ls $destResultPath/${TestCase}_${TestMode}_*.ini | wc -l`
echo Node_count is:$Node_count

if [ $Node_count -ne $count_nodes ];
then
  echo "$TestMode file count is not $count_nodes!Please check it!"
  exit 1
fi


echo -------------------------------------------------------------

#读取测试结果情况，并将本组测试结果跑分情况写入Excel文件

python -c 'import write_Excel_UnixBench_16thread; write_Excel_UnixBench_16thread.writeResult("'$TestType'","'$Platform'","'$TestCase'","'$TestMode'","'$Node_count'")'
