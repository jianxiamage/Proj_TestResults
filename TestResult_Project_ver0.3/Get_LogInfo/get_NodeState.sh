#!/bin/bash

#-------------------------------------------------

if [ $# -ne 3 ];then
 echo "usage: $0 TestType Platform NodeIP" 
 exit 1
fi

#-------------------------------------------------
TestType=$1
Platform=$2
NodeIP=$3
#-------------------------------------------------
NodeUser='root'
NodePass='loongson'
#--------------------------------------------
test_logDir="/Test_Log"  #远程节点log目录
AutoTestDir="/AutoTest"  #本地备份目录
#--------------------------------------------

echo "***************************************************"
start_time=`date +%s`              #定义脚本运行的开始时间

cmdStr="To check the state of the node:[${NodeIP}] Begin.======================="
echo $cmdStr

#首先尝试目标节点是否能够ping通
ping -c3 -i0.3 -W1 $NodeIP &>/dev/null
if [ $? -ne 0 ] ;then
  cmdStr="Error,[${NodeIP}] can not be connected!"
  echo $cmdStr
  cmdStr="Maybe the test node was down or some stress test is running!"
  echo $cmdStr
  exit 2
fi

#首先尝试目标节点是否能够ssh连接成功
sshpass -p $NodePass  ssh -o StrictHostKeyChecking=no -o ConnectTimeout=3 -o ConnectionAttempts=1 -o ServerAliveInterval=1 \
$NodeUser@$NodeIP "echo test ssh connection > /dev/null 2>&1"
retCode=$?

if [ $retCode -ne 0 ];
then
  cmdStr="Error,connect to [${NodeIP}] by ssh failed!"
  echo $cmdStr
  exit 3
fi


stop_time=`date +%s`  #定义脚本运行的结束时间
echo "***************************************************"
cmdStr="[${NodeIP}] Exec Time:`expr $stop_time - $start_time`s"
echo $cmdStr
echo "***************************************************"

cmdStr="To check the state of the node:[${NodeIP}] End.======================="
echo $cmdStr
