#!/bin/bash

#--------------------------------------------
ServerUser='root'
ServerPass='loongson'
#--------------------------------------------

if [ $# -ne 3 ];then
   echo "usage: $0 TestType Platform TestCase" 
   exit 1
fi

TestType="$1"
Platform="$2"
TestCase="$3"

retCode=0

echo "-----------------------------------------------------------------------------"
OSInfoDir="OSInfo"
#destPath="${TestType}/${Platform}/${OSInfoDir}/$TestCase/"
#mkdir $destPath -p

onLineFlag=0
function getOSInfo()
{
   if [ $# -ne 1 ];then
     echo "usage: $0 opt_name"
     return 1
   fi
   
   retCode=0
   opt_name="$1"
   i=1

   IPCount_File="${TestType}/${Platform}/${opt_name}_IP_Mark.txt"
   echo "Begin to get the os info of the remote Node,TestType:[$TestType],Platform:[$Platform],TestCase:[$opt_name]"
  
   IP_testcase=$(python -c 'import get_node_ip; print get_node_ip.getResult("'$TestType'","'$Platform'","'$opt_name'","'$i'")')
   ping -c3 -i0.3 -W1 $IP_testcase &>/dev/null
   if [ $? -ne 0 ] ;then
       echo "[${IP_testcase}] can not be connected!"
       onLineFlag=1
   fi
   sshpass -p $ServerPass  ssh -o StrictHostKeyChecking=no -o ConnectTimeout=3 -o ConnectionAttempts=1 -o ServerAliveInterval=1  ${ServerUser}@${IP_testcase} "cat /home/os_info.txt" >> "OSInfo_${TestType}_${Platform}.txt"
   if [ $? -ne 0 ];then
     echo "Get the OS info file failed!"
     retCode=1
   fi
   
}

#下载远程节点系统信息到本地
getOSInfo $TestCase || { exit $retCode; }

echo "--------------------------------------------------------"
retCode=$onLineFlag
exit $retCode
