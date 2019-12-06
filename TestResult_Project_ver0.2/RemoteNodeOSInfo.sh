#!/bin/bash

#-------------------------------------------------
#脚本功能:获取目标测试机器的系统信息
#包括操作系统类型及版本，内核版本信息
#-------------------------------------------------

if [ $# -ne 2 ];then
 echo "usage: $0 TestType Platform" 
 exit 1
fi

#-------------------------------------------------
TestType="$1"
Platform="$2"
#-------------------------------------------------

start_time=`date +%s`              #定义脚本运行的开始时间


echo "*********************************************************"
echo "Begin to get the OS Info of the test nodes..."
pushd Get_OSInfo_Remote
sh Get_OSInfo_Multi_Select.sh ${TestType} ${Platform}
popd
echo "Get the OS Info of the test nodes End."


stop_time=`date +%s`  #定义脚本运行的结束时间

echo "***************************************************"
echo "Exec Time:`expr $stop_time - $start_time`s"
echo "***************************************************"
