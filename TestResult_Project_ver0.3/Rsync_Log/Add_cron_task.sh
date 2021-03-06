#!/usr/bin/env bash

#-------------------------------------------------
#脚本功能:创建定时任务收集测试结果
#输入参数:测试类型，测试平台
#摘要:根据输入参数的不同，创建定时任务，
#     每隔5分钟,更新刷新一次测试结果展示界面
#-------------------------------------------------

#-------------------------------
#功能调用脚本
#./Operation_CronTab.sh
#-------------------------------

if [ $# -ne 2 ];then
 echo "usage: $0 TestType Platform" 
 exit 1
fi

#-------------------------------------------------
TestType="$1"
Platform="$2"
#-------------------------------------------------

#添加定时任务
sh Operation_CronTab.sh ${TestType} ${Platform} add
