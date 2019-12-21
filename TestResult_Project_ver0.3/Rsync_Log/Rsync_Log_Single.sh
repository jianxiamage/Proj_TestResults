#!/bin/bash

#-------------------------------------------------
#设置环境变量，防止定时任务调用时出错
#. /etc/profile
#. ~/.bash_profile
source /etc/profile
#-------------------------------------------------

if [ $# -ne 2 ];then
 echo "usage: $0 TestType Platform" 
 exit 1
fi

#--------------------------------------------
TestType="$1"
Platform="$2"
#--------------------------------------------
#-------------------------------------------------
logFile="RsyncLog_${TestType}_${Platform}.log"
#-------------------------------------------------
source ../Common_Func/create_LogFile.sh $logFile
#-------------------------------------------------
#--------------------------------
source ./ini_operation.sh
readIni=$readIni
#--------------------------------
#--------------------------------------------------------------------
resultsPath=/data
IPListIniFile='ip_list.ini'
ip_list_path=${resultsPath}/${TestType}/${Platform}/${IPListIniFile}
err_file=err_file.txt
test_logDir="/Test_Log"  #远程节点log目录
#--------------------------------------------------------------------
echo "ip_list_path is:$ip_list_path"

count_items=$(cat node_count.cfg)
echo count_items is:$count_items 

group_count=$(cat ../Common_Func/group_count_${TestType}.cfg)
echo group_count is:$group_count

ip_file="${TestType}_${Platform}_ipList.txt"
rm -rf $ip_file

#------------------------------------------------------------------------
#因为当前不是所有组的机器都在测试范围，例如第5组，第7组为空
#而且，如果测试类型为：OS，则有第15组，测试类型为：Kernel，则没有第15组，
#因此，以下逻辑为不同测试类型的分组具体情况
#------------------------------------------------------------------------
if [ "$TestType"=="Kernel" ];
then
  group_list="1 2 3 4 6 8 9 10"
elif [ "$TestType"=="OS" ];
  then
  group_list="1 2 3 4 6 8 9 10 15"
else
  group_list="1 2 3 4 6 8 9 10 15"
fi
  
#------------------------------------------------------
#函数功能:
#将所有测试节点ip放入一个文件中，便于之后进行循环遍历
#------------------------------------------------------
function get_NodeIP()
{
   for i in $group_list
   do
     for((j=1;j<=count_items;j++));
     do
       NodeNum=$j
       Group_num=$i
       sectionName="Group${Group_num}"
       keyName="ip_${NodeNum}"
       #echo "第[$j] 个keyName:$keyName"
       IP_testcase=$(readIni $ip_list_path $sectionName $keyName)
       #记录每个ip到一个文件中
       echo $IP_testcase  >>  $ip_file
     done
   done
}

function write_outputInfo()
{
  if [ $# -ne 2 ];then
    echo "usage: $0 NodeIP retCode" 
    return 1
  fi
 
  NodeIP=$1
  retCode=$2 

  case $retCode in

    0)
       cmdStr="OK,Data synchronization with node [${NodeIP}] succeeded!"
       echo $cmdStr
       write_log "INFO" "${cmdStr}"

       ;;
    2)
       cmdStr="Error,[${NodeIP}] can not be connected(ping error)!"
       echo $cmdStr
       write_log "ERROR" "${cmdStr}"
       cmdStr="Maybe the test node was down or some stress test is running!"
       echo $cmdStr
       write_log "ERROR" "${cmdStr}"

       ;;
    3)
       cmdStr="Error,[${NodeIP}] can not be connected by ssh!"
       echo $cmdStr
       write_log "ERROR" "${cmdStr}"

       ;;
    4)
       cmdStr="Error,[${NodeIP}] has no directory named [${test_logDir}]!"
       echo $cmdStr
       write_log "ERROR" "${cmdStr}"

        ;;
    5)
       cmdStr="Error,Data synchronization with node [${NodeIP}] failed!"
       echo $cmdStr
       write_log "ERROR" "${cmdStr}"

       ;;
    *)
       cmdStr="Error,Some unknown error occured with [${NodeIP}]!"
       echo $cmdStr
       write_log "ERROR" "${cmdStr}"
       ;;
  esac
}



:> $err_file
start_time=`date +%s`              #定义脚本运行的开始时间

#调用函数，生成ip列表文件
get_NodeIP

#将文件中存储的ip列表转换成数组
#declare -a nodeIP_list
#nodeIP_list=($(cat $ip_file))
#
#nodeIP_list_len=${#nodeIP_list[*]}
#echo "节点数量:$nodeIP_list_len"

for line in `cat ${ip_file}`
do
{
  node_ip=$line
  echo "当前测试用例:$node_ip" 
  sh rsync_Log.sh $TestType $Platform $node_ip
  retCode=$?
  if [ $retCode -ne 0 ]
  then
    echo $node_ip >> $err_file
  fi

  #根据执行结果不同返回值，写入不同的log信息,记录程序的运行状况
  write_outputInfo ${node_ip} ${retCode}
}
done

echo "***************************************************"
stop_time=`date +%s`  #定义脚本运行的结束时间
echo "***************************************************"
echo "Download Log files Exec Time:`expr $stop_time - $start_time`s"
echo "***************************************************"
