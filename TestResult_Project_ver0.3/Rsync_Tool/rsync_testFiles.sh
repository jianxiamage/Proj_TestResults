#!/bin/bash

#-------------------------------------------------
#设置环境变量，防止定时任务调用时出错
#. /etc/profile
#. ~/.bash_profile
source /etc/profile
#-------------------------------------------------

#-------------------------------------------------
logFile="Rsync_AutoTestFiles.log"
#-------------------------------------------------

#-------------------------------------------------
source ../Common_Func/create_LogFile.sh $logFile
#-------------------------------------------------

#--------------------------------------------
ServerDomain='auto_test.loongson.cn'
ServerUser='loongson-test'
ServerPass='loongson'
#--------------------------------------------

AutoTestDir='/AutoTest'
ServerTestDir='autotest_result1'
#--------------------------------------------
#域名转IP
ServerIP=`dig +short $ServerDomain`
#--------------------------------------------
LogFile_Rsync=/var/log/local_rsyncd.log

echo "***************************************************"
start_time=`date +%s`              #定义脚本运行的开始时间

cmdStr="To rsync the test result files with Server:[${ServerIP}] Begin.-------------------------------"
echo $cmdStr
write_log "INFO" "${cmdStr}"


sshpass -p $ServerPass  ssh -o StrictHostKeyChecking=no -o ConnectTimeout=3 -o ConnectionAttempts=1 -o ServerAliveInterval=1 \
"[ -d ~/${ServerTestDir} ]" 
retCode=$?

if [ $retCode -ne 0 ];
then 
  cmdStr="Error,No Directory named [${ServerTestDir}] on Server:[${ServerIP}]!"
  echo $cmdStr
  write_log "INFO" "${cmdStr}"
  exit 1
fi

rm -rf ${LogFile_Rsync}
sshpass -p $ServerPass rsync -avzP --delete -e 'ssh -p 22' --log-file="${LogFile_Rsync}" \
$ServerUser@$ServerDomain:~/$ServerTestDir $AutoTestDir
retCode=$?

if [ $retCode -ne 0 ];
then
  cmdStr="Error,Rsync data with Server:[${ServerIP}] failed!"
  echo $cmdStr
  write_log "INFO" "${cmdStr}"
  exit 1
fi

#rsync -avz --delete $ServerUser@$ServerDomain:~/$ServerTestDir $AutoTestDir

stop_time=`date +%s`  #定义脚本运行的结束时间

echo "***************************************************"
cmdStr="Exec Time:`expr $stop_time - $start_time`s"
echo $cmdStr
write_log "INFO" "${cmdStr}"
echo "***************************************************"

cmdStr="To rsync the test result files with Server:[${ServerIP}] End.---------------------------------"
echo $cmdStr
write_log "INFO" "${cmdStr}"

