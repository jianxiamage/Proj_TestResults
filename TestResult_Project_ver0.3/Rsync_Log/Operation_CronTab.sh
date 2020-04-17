#!/usr/bin/env bash

#-------------------------------------------------
#脚本功能:创建定时任务收集测试结果
#输入参数:测试类型，测试平台
#摘要:根据输入参数的不同，创建定时任务，
#     每隔5分钟,更新刷新一次测试结果展示界面
#-------------------------------------------------

if [ $# -ne 3 ];then
 echo "usage: $0 TestType Platform Option" 
 exit 1
fi

#-------------------------------------------------
TestType="$1"
Platform="$2"
Option="$3"
#-------------------------------------------------

CUR_PATH=$(cd "$(dirname "$0")"; pwd)
#last_dir=$(cd ../"$(dirname "$0")"; pwd)  #要定时调用的脚本在本目录的上一层

#输入参数标记
Para_Tag="${TestType} ${Platform}"
crontabFile_Tag="${TestType}_${Platform}"

#要定时执行的任务
TASK_CMD="cd ${CUR_PATH}; ./Rsync_Log_Multi.sh ${Para_Tag}"

#替换关键字
keyword="Rsync_Log_Multi.sh ${Para_Tag}"

# 要添加的crontab任务计划
CRONTAB_TASK="*/5 * * * * ${TASK_CMD}"

#备份原始crontab记录文件
CRONTAB_BAK_FILE="${CUR_PATH}/crontab_bak_Log_${crontabFile_Tag}"

# 创建crontab任务函数
function add_crontab()
{
    echo 'Create crontab task...'
    crontab -l > ${CRONTAB_BAK_FILE} 2>/dev/null

    echo "Task Name:-------------------------------------------------------------------------------------"
    echo "${CRONTAB_TASK}"
    echo "Task Name:-------------------------------------------------------------------------------------"
    
    #调试内容
    #echo "替换之前"
    #cat $CRONTAB_BAK_FILE
    #echo "替换之前"

    #sed -i "#.*${TASK_CMD}#d" ${CRONTAB_BAK_FILE}  # 已存在任务时会被sed删除，防止重复添加
    sed -i "/${keyword}/d" ${CRONTAB_BAK_FILE}  # 已存在任务时会被sed删除，防止重复添加

    #echo "替换之后"
    #cat $CRONTAB_BAK_FILE
    #echo "替换之后"

    #添加新的任务计划
    echo "${CRONTAB_TASK}" >> ${CRONTAB_BAK_FILE}
    crontab ${CRONTAB_BAK_FILE}
    
    echo 'Add task Complete'
}

# 清除crontab任务函数
function remove_crontab(){
    echo 'Delete crontab task...'
    crontab -l > ${CRONTAB_BAK_FILE} 2>/dev/null
    #sed -i "/.*${SCRIPT_NAME}/d" ${CRONTAB_BAK_FILE}
    #sed -i "/${Para_Tag}/d" ${CRONTAB_BAK_FILE}  # 已存在任务时会被sed删除，防止重复添加
    sed -i "/${keyword}$/d" ${CRONTAB_BAK_FILE}  # 已存在任务时会被sed删除，防止重复添加
    crontab ${CRONTAB_BAK_FILE}
    
    echo 'Delete task Complete'
}

#选择操作
case $Option in
    'add' )
        #添加定时任务
        add_crontab
        ;;
    'remove' )
        #删除定时任务
        remove_crontab
        ;;
esac
