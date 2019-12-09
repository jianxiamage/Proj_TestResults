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


sshpass -p $ServerPass rsync -avz --delete -e 'ssh -p 22' \
$ServerUser@$ServerIP:~/$ServerTestDir $AutoTestDir

#rsync -avz --delete $ServerUser@$ServerIP:~/$ServerTestDir $AutoTestDir

stop_time=`date +%s`  #定义脚本运行的结束时间
echo "***************************************************"
echo "Exec Time:`expr $stop_time - $start_time`s"
echo "***************************************************"
