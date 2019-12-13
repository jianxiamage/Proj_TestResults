#!/bin/bash

#-------------------------------------------------
#设置环境变量，防止定时任务调用时出错
#. /etc/profile
#. ~/.bash_profile
source /etc/profile
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

sshpass -p $ServerPass  ssh -o StrictHostKeychecking=no $ServerUser@$ServerDomain \
"[ -d ~/${ServerTestDir} ]" 
retCode=$?

if [ $retCode -ne 0 ];
then 
  echo "Error,No Directory named [${ServerTestDir}] on Server:[${ServerIP}]!"
  exit 1
fi

rm -rf ${LogFile_Rsync}
sshpass -p $ServerPass rsync -avzP --delete -e 'ssh -p 22' --log-file="${LogFile_Rsync}" \
$ServerUser@$ServerDomain:~/$ServerTestDir $AutoTestDir
retCode=$?

if [ $retCode -ne 0 ];
then
  echo "Error,Rsync data with Server:[${ServerIP}] failed!"
  exit 1
fi

#rsync -avz --delete $ServerUser@$ServerDomain:~/$ServerTestDir $AutoTestDir

stop_time=`date +%s`  #定义脚本运行的结束时间

echo "***************************************************"
echo "Exec Time:`expr $stop_time - $start_time`s"
echo "***************************************************"
