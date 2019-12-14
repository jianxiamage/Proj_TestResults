#!/bin/bash

#-------------------------------------------------
#设置环境变量，防止定时任务调用时出错
#. /etc/profile
#. ~/.bash_profile
source /etc/profile
#-------------------------------------------------

#-------------------------------------------------
logFile="Rsync_Server_ResultsFiles.log"
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
ServerTestDir='autotest_result'
#--------------------------------------------
#域名转IP
ServerIP=`dig +short $ServerDomain`
#--------------------------------------------
LogFile_Rsync=/var/log/local_rsyncd.log

echo "***************************************************"
start_time=`date +%s`              #定义脚本运行的开始时间

cmdStr="To rsync the test result files with Server:[${ServerIP}] Begin.---------------------"
echo $cmdStr
write_log "INFO" "${cmdStr}"

cmdStr="SourcePath:[~/${ServerTestDir}] -->From Server:[${ServerIP}]"
echo $cmdStr
write_log "INFO" "${cmdStr}"

cmdStr="DestPath:  [~/${ServerTestDir}] -->To Local:[${AutoTestDir}/${ServerTestDir}]"
echo $cmdStr
write_log "INFO" "${cmdStr}"

sshpass -p $ServerPass  ssh -o StrictHostKeyChecking=no -o ConnectTimeout=3 -o ConnectionAttempts=1 -o ServerAliveInterval=1 \
$ServerUser@$ServerIP "[ -d ~/${ServerTestDir} ]" 
retCode=$?

if [ $retCode -ne 0 ];
then 
  cmdStr="Error,No Directory named [${ServerTestDir}] on Server:[${ServerIP}]!"
  echo $cmdStr
  write_log "ERROR" "${cmdStr}"
  exit 1
fi

rm -rf ${LogFile_Rsync}
sshpass -p $ServerPass rsync -avzP --delete -e 'ssh -p 22' --log-file="${LogFile_Rsync}" \
$ServerUser@$ServerIP:~/$ServerTestDir $AutoTestDir
retCode_rsync=$?

#rsync -avz --delete $ServerUser@$ServerDomain:~/$ServerTestDir $AutoTestDir

cmdStr="The detail rsync log(path:[${LogFile_Rsync}])"
echo $cmdStr
write_log "INFO" "${cmdStr}"

#为显示更加清晰，log前面加入空格占位
#pre_str='[INFO : 2019-12-14 09:56:01] : ' #例子
pre_str='                               '
tmp_LogFile_Rsync=${LogFile_Rsync}.tmp
\cp ${LogFile_Rsync} ${tmp_LogFile_Rsync} -f
sed -i "2,\$s/^/${pre_str}&/g" ${tmp_LogFile_Rsync}

cmdStr=$(cat ${tmp_LogFile_Rsync})
echo $cmdStr
write_log "INFO" "${cmdStr}"

if [ $retCode_rsync -ne 0 ];
then
  cmdStr="Error,Data synchronization with Server [${ServerIP}] failed!"
  echo $cmdStr
  write_log "ERROR" "${cmdStr}"
  exit 1
else
  cmdStr="OK,Data synchronization with Server [${ServerIP}] succeeded!"
  echo $cmdStr
  write_log "INFO" "${cmdStr}"
fi

stop_time=`date +%s`  #定义脚本运行的结束时间
echo "***************************************************"
cmdStr="Exec Time:`expr $stop_time - $start_time`s"
echo $cmdStr
write_log "INFO" "${cmdStr}"
echo "***************************************************"

cmdStr="To rsync the test result files with Server:[${ServerIP}] End.-----------------------"
echo $cmdStr
write_log "INFO" "${cmdStr}"
