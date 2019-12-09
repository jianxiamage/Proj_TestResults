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

#--------------------------------
source ./ini_operation.sh
readIni=$readIni
#--------------------------------
#----------------------------------------------------------------------------------
resultsPath='/data'
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
   if [ $# -ne 1 ];then
     echo "usage: $0 opt_name"
     return 1
   fi
   
   retCode=0
   opt_name="$1"
   i=1

   echo "Begin to get the os info of the remote Node:"
   echo "TestType:[$TestType],Platform:[$Platform],TestCase:[$opt_name]"
  
   #IP_testcase=$(python -c 'import get_node_ip; print get_node_ip.getResult("'$TestType'","'$Platform'","'$opt_name'","'$i'")')
   Group_num=$(sh get_GroupNum.sh $TestType $opt_name)
   sectionName="Group${Group_num}"
   keyName="ip_${NodeNum}"
   #echo "keyName:$keyName"
   IP_testcase=$(readIni $ip_list_path $sectionName $keyName)

   ping -c3 -i0.3 -W1 $IP_testcase &>/dev/null
   if [ $? -ne 0 ] ;then
       echo "[${IP_testcase}] can not be connected!"
       retCode=$1
       return $retCode
   fi

   echo "[${IP_testcase}] can be connected."

   sshpass -p $ServerPass  ssh -o StrictHostKeyChecking=no -o ConnectTimeout=3 -o ConnectionAttempts=1 -o ServerAliveInterval=1 \
   ${ServerUser}@${IP_testcase} "cat /.buildstamp" > "${BuildInfoFile}"
   if [ $? -ne 0 ];then
     echo "Get the OS info file failed!"
     retCode=1
     return $retCode
   fi
   
   sshpass -p $ServerPass  ssh -o StrictHostKeyChecking=no -o ConnectTimeout=3 -o ConnectionAttempts=1 -o ServerAliveInterval=1 \
   ${ServerUser}@${IP_testcase} "uname -r" > "${KernelVerFile}"
   if [ $? -ne 0 ];then
     echo "Get the Kernel info file failed!"
     retCode=1
     return $retCode
   fi

   
   kernel_ver=$(cat ${KernelVerFile})
   echo "Kernel info:${kernel_ver}"

   kernel_ver_Str="Kernel_Version=${kernel_ver}"
   #echo $kernel_ver_Str
   sed -i "/Compose/i\\${kernel_ver_Str}" "${BuildInfoFile}"

   #将系统类型和版本号写入文件中，便于调用
   os_type=`cat ${BuildInfoFile} |grep Product | awk -F"=" '{print $2}'`
   echo ${os_type} > ${OSTypeFile}
   os_version=`cat ${BuildInfoFile} |grep UUID | awk -F"=" '{print $2}'`
   echo ${os_version} > ${OSVerFile}

   echo "Get the OS info file success."
   
}

#下载远程节点系统信息到本地
getOSInfo $TestCase || { exit $retCode; }

echo "--------------------------------------------------------"
exit $retCode
