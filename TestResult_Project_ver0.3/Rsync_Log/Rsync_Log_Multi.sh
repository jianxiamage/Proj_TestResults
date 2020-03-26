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
if [ "$TestType" == "Kernel" ];
then
  group_list="1 2 3 4 6 8 9 10"
elif [ "$TestType" == "OS" ];
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

#------------------------------------------------------
#函数功能:
#根据同步测试节点的执行日志情况，写入本程序日志，
#用以说明当前程序的执行情况
#------------------------------------------------------
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

#---------------------------------------------------------------------

:> $err_file
start_time=`date +%s`              #定义脚本运行的开始时间

#调用函数，生成ip列表文件
get_NodeIP

#-------------------------------------------------------------
#将文件中存储的ip列表转换成数组
#清理ssh环境，防止目标节点认证发生改变时，ssh连接失败的情况
#清理原因:
#一台主机上有多个Linux系统，会经常切换
#(如重装系统或者重新拷盘，但保持ip不变)，那么这些系统使用同一ip，
#登录过一次后就会把ssh信息记录在本地的~/.ssh/known_hsots文件中，
#切换该系统后再用ssh访问这台主机就会出现冲突警告
#-------------------------------------------------------------
cmdStr="Delete the public key in the file:~/.ssh/knownhosts!"
echo $cmdStr
write_log "INFO" "${cmdStr}"

#将文件中存储的ip列表转换成数组
declare -a nodeIP_list
nodeIP_list=($(cat $ip_file))

nodeIP_list_len=${#nodeIP_list[*]}
echo "节点数量:$nodeIP_list_len"

#echo 数组大小:$nodeIP_list_len
i=0
while [ $i -lt $nodeIP_list_len ]
do
  echo -----------这是第$[i+1]个IP:开始--------------
  node_ip=$(echo ${nodeIP_list[$i]} | awk -F ' ' '{print $1}')
  echo node ip is :$node_ip
  ssh-keygen -R $node_ip
  echo -----------这是第$[i+1]个IP:结束--------------
  let i++
done
#-------------------------------------------------------------

#start_time=`date +%s`              #定义脚本运行的开始时间
[ -e /tmp/fd1 ] || mkfifo /tmp/fd1 #创建有名管道
exec 3<>/tmp/fd1                   #创建文件描述符，以可读（<）可写（>）的方式关联管道文件，此时文件描述符3就有了有名管道文件的所有特性
rm -rf /tmp/fd1                    #关联后的文件描述符拥有管道文件的所有特性,因此这时管道文件可以删除，留下文件描述符使用即可
for ((i=1;i<=15;i++))
do
        echo >&3                   #&3代表引用文件描述符3，这条命令代表往管道里面放入了一个"令牌"
done


for line in `cat ${ip_file}`
do
read -u3                           #代表从管道中读取一个令牌
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

  echo >&3                         #本次命令执行到最后，把令牌放回管道
}&
done
wait

echo "***************************************************"
stop_time=`date +%s`  #定义脚本运行的结束时间
echo "***************************************************"
echo "Download Log files Exec Time:`expr $stop_time - $start_time`s"
echo "***************************************************"
exec 3<&-                         #关闭文件描述符的读
exec 3>&-                         #关闭文件描述符的写

#------------------------------------------------------------------------
