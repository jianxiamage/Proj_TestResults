#!/bin/bash

#--------------------------------------------
ServerDomain='auto_test.loongson.cn'
ServerUser='loongson-test'
ServerPass='loongson'
autotest_dir='autotest_result'
#--------------------------------------------
ServerIP=`dig +short $ServerDomain`
#--------------------------------------------
resultsPath='/data'
#--------------------------------------------
AutoTestDir='/AutoTest'
ServerTestDir='autotest_result'
#OS_InfoDir="/home/${ServerUser}/${autotest_dir}/OS_Info"
OS_InfoDir="${AutoTestDir}/${autotest_dir}/OS_Info"
#--------------------------------------------

if [ $# -ne 2 ];then
   echo "usage: $0 TestType Platform" 
   exit 1
fi

TestType="$1"
Platform="$2"

#------------------------------------------------------------------
#记录节点在线状态的目录
node_state_Path=$resultsPath/$TestType/$Platform/Detail/NodeState
node_state_File=$node_state_Path/OnLine.txt
#------------------------------------------------------------------

retCode=0

echo "--------------------------------------------------------"
#echo "检查是否所有节点都不在线，如果是，则退出"

echo "TestType:[$TestType],Platform:[$Platform]"

if [ ! -s $node_state_File ]
then
  echo "File:[${node_state_File}] is not existed!"
  echo "No OnLine file exists!"
  retCode=1
  exit $retCode
fi

echo "Get the OS info file success."

echo "--------------------------------------------------------"
