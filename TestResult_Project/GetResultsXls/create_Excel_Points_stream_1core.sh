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
TestMode="1core"
#----------------------------------------------------------------------------------------
resultsPath='/data'
PointsPath='Points_Files'
Node_count=0
#----------------------------------------------------------------------------------------
#测试结果文件(筛选内容后)地址
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
#目前测试节点个数规定：每个测试小组有三个节点，node_count.cfg中的数字3代表三个节点
count_nodes=`cat node_count.cfg` || { echo "File:node_count.cfg is not existed!";exit 1;}

ls -l $destResultPath/${TestCase}_${TestMode}_*.ini

#若出错，说明没有找到相关ini文件，程序退出
if [ $? -ne 0 ];
then
  echo "No $TestMode files exists!Please check it!"
  exit 1
fi

Node_count=`ls $destResultPath/${TestCase}_${TestMode}_*.ini | wc -l`
echo Node_count is:$Node_count

#规定：每个测试小组有三个节点，当前找到的ini文件数量和node_count.cfg中的数字不同则出错退出
if [ $Node_count -ne $count_nodes ];
then
  echo "$TestMode file count is not $count_nodes!Please check it!"
  exit 1
fi

echo -------------------------------------------------------------

#读取iozone测试结果情况，并将本组测试结果跑分情况写入Excel文件

python -c 'import write_Excel_stream_1core; write_Excel_stream_1core.writeResult("'$TestType'","'$Platform'","'$TestCase'","'$TestMode'","'$Node_count'")'



