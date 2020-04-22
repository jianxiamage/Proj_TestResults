#!/bin/bash

#######################################################################
#功能：
#将每种性能测试生成的跑分文件(Excel)合并为一个文件
#######################################################################


if [ $# -ne 2 ];then
 echo "usage: $0 TestType Platform" 
 exit 1
fi
#----------------------------------------------------------------------------------------
TestType="$1"
Platform="$2"
#----------------------------------------------------------------------------------------

#生成Excel文件用到了python插件，为并避免对服务器python环境造成影响，
#使用python虚拟环境执行命令
export WORKON_HOME=/home/work/env-wrapper

echo ---------------------------------
echo 'active the virtualenvwrapper'
echo ---------------------------------
source /usr/bin/virtualenvwrapper.sh

echo ---------------------------------
echo 'change to virtualenv:env-excel'
echo ---------------------------------
workon env-excel

echo "Begin to merge excel files..."

python -c 'import summary_Excel_Results; summary_Excel_Results.summaryExcel("'$TestType'","'$Platform'")'
