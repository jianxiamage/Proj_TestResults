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
resultsPath='/data'
PointsPath='Points_Files'
Node_count=0
node_count_file='../../node_count.cfg'
#----------------------------------------------------------------------------------------
#测试结果文件(筛选内容后)地址
detailDir="Detail"
destResultPath="${resultsPath}/${TestType}/${Platform}/${detailDir}/${TestCase}/${PointsPath}"

#目录未生成，可能测试未开始
if [ ! -s $destResultPath ];
then
  echo "Warnning! [$destResultPath] not existed!Maybe [$TestCase] Not Begin!"
  mkdir $destResultPath -p
  #exit 1
fi

echo -------------------------------------------------------------

#目前测试节点个数规定：每个测试小组有三个节点，node_count.cfg中的数字3代表三个节点
count_nodes=`cat $node_count_file` || { echo "File:node_count.cfg is not existed!";exit 1;}

ls -l $destResultPath/$TestCase*.ini

#若出错，说明没有找到相关ini文件,需要初始化文件
if [ $? -ne 0 ];
then
  echo "No $TestCase files exists!Please check it!"
  #exit 1
fi

Node_count=`ls $destResultPath/$TestCase*.ini | wc -l`
echo Node_count is:$Node_count

#若当前查找到的ini文件数不是node_count.cfg的设定值，则失败退出
if [ $Node_count -ne 0 -a $Node_count -ne $count_nodes ];
then
  echo "$TestCase file count is not $count_nodes!Please check it!"
  exit 1
fi

echo -------------------------------------------------------------

#读取测试结果情况，并将本组测试结果跑分情况写入配置文件

for ((i=1; i<=${count_nodes}; i++))
do
  echo "$TestType $Platform $TestCase Node:[$i]"
  sh get_SpecJvm2008_pointValue.sh $TestType $Platform $TestCase $i || { echo "Error!Node [$i]";exit 1; }
done

