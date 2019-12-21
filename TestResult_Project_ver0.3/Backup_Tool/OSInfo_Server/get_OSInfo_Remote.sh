#!/bin/bash

#--------------------------------------------
ServerDomain='auto_test.loongson.cn'
ServerUser='loongson-test'
ServerPass='loongson'
autotest_dir='autotest_result'
#--------------------------------------------
ServerIP=`dig +short $ServerDomain`
#--------------------------------------------

AutoTestDir='/AutoTest'
ServerTestDir='autotest_result'
OS_InfoDir="/home/${ServerUser}/${autotest_dir}/OS_Info"
#--------------------------------------------

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

   sshpass -p $ServerPass  scp -o StrictHostKeyChecking=no -o ConnectTimeout=3 -o ConnectionAttempts=1 -o ServerAliveInterval=1 \
   $ServerUser@$ServerIP:$OS_InfoDir/${IP_testcase}_osinfo.txt ${BuildInfoFile}

   #\cp ${IP_testcase}_osinfo.txt ${BuildInfoFile} -f
   #"${BuildInfoFile}"
   if [ $? -ne 0 ];then
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
getOSInfo $TestCase || { exit $retCode; }

echo "--------------------------------------------------------"
exit $retCode
