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
#----------------------------------------------------------------------------------------
TestSel="8" #TestSel 代表选择那一种线程测试
TestMode="INDEX"
#----------------------------------------------------------------------------------------
resultsPath=$(cat data_path.txt)
PointsPath='Points_Files'
Node_count=0
#----------------------------------------------------------------------------------------
#测试结果文件(筛选内容后)地址
destResultPath="${resultsPath}/${TestType}/${Platform}/$TestCase/$PointsPath"

if [ ! -s $destResultPath ];
then
  echo Error! [$destResultPath] not existed!Please check it!
  exit 1
fi

#UnixBench 单线程,BASELINE
echo -------------------------------------------------------------

#目前测试节点个数规定：每个测试小组有三个节点，node_count.cfg中的数字3代表三个节点
count_nodes=`cat node_count.cfg` || { echo "File:node_count.cfg is not existed!";exit 1;}

ls -l $destResultPath/${TestCase}_${TestSel}_${TestMode}*.ini

#若出错，说明没有找到相关ini文件，程序退出
if [ $? -ne 0 ];
then
  echo "No $TestSel files exists!Please check it!"
  exit 1
fi

Node_count=`ls $destResultPath/${TestCase}_${TestSel}_*.ini | grep ${TestMode} | wc -l`
echo Node_count is:$Node_count

#规定：每个测试小组有三个节点，当前找到的ini文件数量和node_count.cfg中的数字不同则出错退出
if [ $Node_count -ne $count_nodes ];
then
  echo "$TestSel file count is not $count_nodes!Please check it!"
  exit 1
fi

echo -------------------------------------------------------------

#读取测试结果情况，并将本组测试结果跑分情况写入Excel文件

python -c 'import write_Excel_UnixBench_8thread_INDEX; write_Excel_UnixBench_8thread_INDEX.writeResult("'$TestType'","'$Platform'","'$TestCase'","'$TestSel'","'$TestMode'","'$Node_count'")'
