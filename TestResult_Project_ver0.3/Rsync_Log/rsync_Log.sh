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
#logFile="RsyncLog_${TestType}_${Platform}_${NodeIP}.log"
logFile="RsyncLog_${TestType}_${Platform}.log"
#-------------------------------------------------
#source ../Common_Func/create_LogFile.sh $logFile
#-------------------------------------------------
NodeUser='root'
NodePass='loongson'
#--------------------------------------------
test_logDir="/Test_Log"  #远程节点log目录
AutoTestDir="/AutoTest"  #本地备份目录
#--------------------------------------------
DestPath=${AutoTestDir}/TestLog_Dir  #同步到本地的目录
rsyncDir=${DestPath}/${TestType}_${Platform}/${NodeIP}_LogDir     #同步到本地的对应节点的Log目录
#--------------------------------------------

mkdir $rsyncDir -p
#--------------------------------------------
LogFile_RsyncDir="/var/log/Log_TestResult/Detail_Rsync_${TestType}_${Platform}"
LogFile_Rsync="${LogFile_RsyncDir}/${NodeIP}.log"
#----------------------------------------

mkdir -p $LogFile_RsyncDir

echo "***************************************************"
start_time=`date +%s`              #定义脚本运行的开始时间

cmdStr="To rsync the test log files with node:[${NodeIP}] Begin.====================="
echo $cmdStr
#write_log "INFO" "${cmdStr}"

cmdStr="SourcePath:[${test_logDir}] -->From Node:[${NodeIP}]"
echo $cmdStr
#write_log "INFO" "${cmdStr}"

cmdStr="DestPath:  [${test_logDir}] -->To Local:[${DestPath}]"
echo $cmdStr
#write_log "INFO" "${cmdStr}"

#首先尝试目标节点是否能够ping通
ping -c3 -i0.3 -W1 $NodeIP &>/dev/null
if [ $? -ne 0 ] ;then
  cmdStr="Error,[${NodeIP}] can not be connected!"
  echo $cmdStr
  #write_log "ERROR" "${cmdStr}"
  cmdStr="Maybe the test node was down or some stress test is running!"
  echo $cmdStr
  #write_log "ERROR" "${cmdStr}"
  exit 2
fi

sshpass -p $NodePass  ssh -o StrictHostKeyChecking=no -o ConnectTimeout=3 -o ConnectionAttempts=1 -o ServerAliveInterval=1 \
$NodeUser@$NodeIP "echo test ssh connection > /dev/null 2>&1"
retCode=$?

if [ $retCode -ne 0 ];
then
  cmdStr="Error,connect to [${NodeIP}] by ssh failed!"
  echo $cmdStr
  #write_log "ERROR" "${cmdStr}"
  exit 3
fi

sshpass -p $NodePass  ssh -o StrictHostKeyChecking=no -o ConnectTimeout=3 -o ConnectionAttempts=1 -o ServerAliveInterval=1 \
$NodeUser@$NodeIP "[ -d ${test_logDir} ]" 
retCode=$?

if [ $retCode -ne 0 ];
then 
  cmdStr="Error,No Directory named [${test_logDir}] on the Node:[${NodeIP}]!"
  echo $cmdStr
  #write_log "ERROR" "${cmdStr}"
  exit 4 
fi

rm -rf ${LogFile_Rsync}
sshpass -p $NodePass rsync -avzP --delete -e 'ssh -p 22' --log-file="${LogFile_Rsync}" \
$NodeUser@$NodeIP:$test_logDir "${rsyncDir}"
retCode_rsync=$?

#rsync -avz --delete $NodeUser@$ServerDomain:~/$test_logDir $AutoTestDir

cmdStr="The detail rsync log(path:[${LogFile_Rsync}])"
echo $cmdStr
#write_log "INFO" "${cmdStr}"

#为显示更加清晰，log前面加入空格占位
#pre_str='[INFO : 2019-12-14 09:56:01] : ' #例子
pre_str='                               '
tmp_LogFile_Rsync=${LogFile_Rsync}.tmp
\cp ${LogFile_Rsync} ${tmp_LogFile_Rsync} -f
sed -i "2,\$s/^/${pre_str}&/g" ${tmp_LogFile_Rsync}

cmdStr=$(cat ${tmp_LogFile_Rsync})
echo $cmdStr
#write_log "INFO" "${cmdStr}"

if [ $retCode_rsync -ne 0 ];
then
  cmdStr="Error,Data synchronization with node [${NodeIP}] failed!"
  echo $cmdStr
  #write_log "ERROR" "${cmdStr}"
  exit 5
else
  cmdStr="OK,Data synchronization with node [${NodeIP}] succeeded!"
  echo $cmdStr
  #write_log "INFO" "${cmdStr}"
fi

stop_time=`date +%s`  #定义脚本运行的结束时间
echo "***************************************************"
cmdStr="[${NodeIP}] Exec Time:`expr $stop_time - $start_time`s"
echo $cmdStr
#write_log "INFO" "${cmdStr}"
echo "***************************************************"

#删除临时文件
rm -rf $tmp_LogFile_Rsync

cmdStr="To rsync the test result files with node:[${NodeIP}] End.======================="
echo $cmdStr
#write_log "INFO" "${cmdStr}"
