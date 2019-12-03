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
resultsPath='/data'
testcaseDir="${TestType}/${Platform}"

rm -rf $testcaseDir/$TestCase
mkdir -p $testcaseDir/$TestCase

echo "-----------------------------------------------------------------------------"
detailDir="Detail"
OSInfoDir="OSInfo"
destPath="${resultsPath}/${TestType}/${Platform}/${detailDir}/${OSInfoDir}/$TestCase/"
rm -rf $destPath
mkdir $destPath -p

onLineFlag=0
function getOSInfo()
{
   if [ $# -ne 1 ];then
     echo "usage: $0 opt_name"
     return 1
   fi
   
   retCode=0
   opt_name="$1"

   IPCount_File="${TestType}/${Platform}/${opt_name}_IP_Mark.txt"
   rm -rf $IPCount_File
   touch $IPCount_File
   echo "Begin to get the os info of the remote Node,TestType:[$TestType],Platform:[$Platform],TestCase:[$opt_name]"
   count_items=$(python -c 'import get_node_count; print get_node_count.getSectionCount("'$TestType'","'$Platform'","'$opt_name'")')
   echo count_items is:$count_items 
  
   for((i=1;i<=count_items;i++));
   do
   {  IP_testcase=$(python -c 'import get_node_ip; print get_node_ip.getResult("'$TestType'","'$Platform'","'$opt_name'","'$i'")')
     echo 第[$i]个ip:$IP_testcase
     ping -c3 -i0.3 -W1 $IP_testcase &>/dev/null
     if [ $? -ne 0 ] ;then
         echo "[${IP_testcase}] can not be connected!"
         onLineFlag=1
         \cp StdOSInfo.ini  "${testcaseDir}/${TestCase}/Node${i}_${IP_testcase}.ini" -f
         continue
     fi
     #sshpass -p $ServerPass  ssh -o StrictHostKeychecking=no ${ServerUser}@${IP_testcase} "cat /.buildstamp" || { echo 'Error!'; continue; }
     #sshpass -p $ServerPass  ssh -o StrictHostKeychecking=no ${ServerUser}@${IP_testcase} "cat /.buildstamp" >> "${testcaseDir}/${TestCase}/Node${i}_${IP_testcase}.ini"
     #sshpass -p $ServerPass  ssh -o StrictHostKeyChecking=no ${ServerUser}@${IP_testcase} "cat /home/os_info.txt" >> "${testcaseDir}/${TestCase}/Node${i}_${IP_testcase}.ini"
     sshpass -p $ServerPass  ssh -o StrictHostKeyChecking=no -o ConnectTimeout=3 -o ConnectionAttempts=1 -o ServerAliveInterval=1  ${ServerUser}@${IP_testcase} "cat /home/os_info.txt" >> "${testcaseDir}/${TestCase}/Node${i}_${IP_testcase}.ini"
     if [ $? -ne 0 ];then
       echo "Get the OS info file failed!"
       \cp StdOSInfo.ini  "${testcaseDir}/${TestCase}/Node${i}_${IP_testcase}.ini" -f
     fi
     echo "${IP_testcase}" >> $IPCount_File
   }&
   done
   wait
   count_ip_result=`cat $IPCount_File|wc -l`
   echo "能够连接的ip个数:${count_ip_result}"
   
   if [ $count_ip_result -ne $count_items ];
   then
     echo "Some nodes can not be connected.Please check it!"
     #exit 1 #此处不能退出，否则不能拷贝ini文件到web服务器
   fi
}

function copyOSInfo2Dest()
{
   retCode=0
   \cp ${testcaseDir}/${TestCase}/Node* $destPath -f || { echo "copy failed"; retCode=1; }
   return $retCode
}

#下载远程节点系统信息到本地
getOSInfo $TestCase || { exit $retCode; }

#复制下载的系统信息到web服务器指定目录下
copyOSInfo2Dest || { exit $retCode; }

echo "--------------------------------------------------------"
retCode=$onLineFlag
exit $retCode
