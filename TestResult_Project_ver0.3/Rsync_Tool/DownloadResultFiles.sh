#!/bin/bash

#--------------------------------------------
ServerIP='auto_test.loongson.cn'
ServerUser='loongson-test'
ServerPass='loongson'
#--------------------------------------------

AutoTestDir='/AutoTest'
ServerTestDir='autotest_result'
#--------------------------------------------


echo "***************************************************"
start_time=`date +%s`              #定义脚本运行的开始时间

#sshpass -p $ServerPass scp -o StrictHostKeychecking=no -r \
sshpass -p $ServerPass  scp -o StrictHostKeyChecking=no -o ConnectTimeout=3 -o ConnectionAttempts=1 -o ServerAliveInterval=1 -r \
$ServerUser@$ServerIP:~/$ServerTestDir/ ${AutoTestDir}
retCode=$?

if [ $retCode -ne 0 ];
then
  echo "Error,download test files from Server:[${ServerIP}] failed!"
  exit 1
fi

stop_time=`date +%s`  #定义脚本运行的结束时间
echo "***************************************************"
echo "Exec Time:`expr $stop_time - $start_time`s"
echo "***************************************************"
