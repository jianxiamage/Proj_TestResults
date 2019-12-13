#!/usr/bin/env bash

#-------------------------------------------------
#脚本功能:创建定时任务收集测试结果
#摘要:创建定时任务，将远程服务器10.2.5.25上的
#     测试结果目录[~/autotest_result]
#     同步到本地/AutoTest目录下
#     每隔2分钟,同步一次测试结果文件到本地服务器
#-------------------------------------------------

if [ $# -ne 1 ];then
 echo "usage: $0 Option" 
 exit 1
fi

#-------------------------------------------------
Option="$1"
cmd_Tag=rsync_testFiles
#-------------------------------------------------

CUR_PATH=$(cd "$(dirname "$0")"; pwd)
#last_dir=$(cd ../"$(dirname "$0")"; pwd)  #要定时调用的脚本在本目录的上一层


#要定时执行的任务
TASK_CMD="cd ${CUR_PATH}; ./rsync_testFiles.sh"

# 要添加的crontab任务计划(暂定2分钟同步一次)
CRONTAB_TASK="*/2 * * * * ${TASK_CMD}"

#备份原始crontab记录文件
CRONTAB_BAK_FILE="${CUR_PATH}/crontab_bak_Server"

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
    sed -i "/${cmd_Tag}/d" ${CRONTAB_BAK_FILE}  # 已存在任务时会被sed删除，防止重复添加

    #echo "替换之后"
    #cat $CRONTAB_BAK_FILE
    #echo "替换之后"

    #添加新的任务计划
    echo "${CRONTAB_TASK}" >> ${CRONTAB_BAK_FILE}
    crontab ${CRONTAB_BAK_FILE}
    
    echo 'Complete'
}

# 清除crontab任务函数
function remove_crontab(){
    echo 'Delete crontab task...'
    crontab -l > ${CRONTAB_BAK_FILE} 2>/dev/null
    #sed -i "/.*${SCRIPT_NAME}/d" ${CRONTAB_BAK_FILE}
    sed -i "/${cmd_Tag}/d" ${CRONTAB_BAK_FILE}  # 已存在任务时会被sed删除，防止重复添加
    crontab ${CRONTAB_BAK_FILE}
    
    echo 'Complete'
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
