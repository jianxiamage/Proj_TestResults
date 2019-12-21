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

#--------------------------------
source ./ini_operation.sh
readIni=$readIni
#--------------------------------
#----------------------------------------------------------------------------------
IPListIniFile='ip_list.ini'
ip_list_path=${resultsPath}/${TestType}/${Platform}/${IPListIniFile}
echo "ip_list_path is:$ip_list_path"
#----------------------------------------------------------------------------------
BuildInfoFile="BuildInfo_${TestType}_${Platform}.txt"

OSTypeFile="OSType_${TestType}_${Platform}.txt"
OSVerFile="OSVer_${TestType}_${Platform}.txt"
KernelVerFile="KernelVer_${TestType}_${Platform}.txt"
#----------------------------------------------------------------------------------

retCode=0

echo "-----------------------------------------------------------------------------"
OSInfoDir="OSInfo"
#destPath="${TestType}/${Platform}/${OSInfoDir}/$TestCase/"
#mkdir $destPath -p

function getOSInfo()
{
   
   retCode=0
   echo "TestType:[$TestType],Platform:[$Platform]"

   IP_testcase=$(cat $node_state_File | head -n 1)

   #sshpass -p $ServerPass  scp -o StrictHostKeyChecking=no -o ConnectTimeout=3 -o ConnectionAttempts=1 -o ServerAliveInterval=1 \
   #$ServerUser@$ServerIP:$OS_InfoDir/${IP_testcase}_osinfo.txt ${BuildInfoFile}

   destFile="$OS_InfoDir/${IP_testcase}_osinfo.txt"
   echo "$destFile"
   if [ ! -s $destFile ]
   then 
     echo "No OnLine file exists!"
     retCode=1
     return $retCode
   fi


   \cp $OS_InfoDir/${IP_testcase}_osinfo.txt ${BuildInfoFile} -f
   retCode=$?

   if [ $retCode -ne 0 ];then
     echo "Download the OS info file failed!"
     retCode=1
     return $retCode
   fi

   #将系统类型和版本号写入文件中，便于调用
   os_type=`cat ${BuildInfoFile} |grep Product | awk -F"=" '{print $2}'`
   echo ${os_type} > ${OSTypeFile}
   os_version=`cat ${BuildInfoFile} |grep UUID | awk -F"=" '{print $2}'`
   echo ${os_version} > ${OSVerFile}
   kernel_version=`cat ${BuildInfoFile} |grep Kernel_Version | awk -F"=" '{print $2}'`
   echo ${kernel_version} > ${KernelVerFile}

   echo "Get the OS info file success."
   
}


#下载远程节点系统信息到本地
getOSInfo $TestCase || { exit 1; }

echo "--------------------------------------------------------"
