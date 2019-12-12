#!/bin/bash

#-------------------------------------------------
#脚本功能:创建定时任务收集测试结果
#输入参数:测试类型，测试平台
#摘要:根据输入参数的不同，创建定时任务，
#     每隔5分钟,更新刷新一次测试结果展示界面
#-------------------------------------------------

if [ $# -ne 2 ];then
 echo "usage: $0 TestType Platform" 
 exit 1
fi

#-------------------------------------------------
TestType="$1"
Platform="$2"
#-------------------------------------------------

rm -f hello.txt

#采用读取文件方式获取定时字符串
#(可行，可用于测试用，但不利于扩展，因为使用的绝对路径需要手动修改)
#job_content=$(cat std_task.file)
#cron_job="${job_content} ${first} ${sec}"

#为方便拓展，直接使用当前目录的上一层
cron_job="*/5 * * * * cd ${last_dir}; ./Result_Collection.sh ${TestType} ${Platform}"

echo "----------------------------------"
echo ${cron_job}
echo "----------------------------------"

( crontab -l | grep -v "$cron_job"; echo "$cron_job" ) | crontab -

#( crontab -l | grep -v "$cron_job" ) | crontab -

