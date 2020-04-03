#!/bin/bash

#---------------------------------------------------
#将测试用例跑分历史结果转换成html文件，方便前端展示
#---------------------------------------------------

#验证参数个数
if [ $# -ne 4 ];then
 echo "usage: $0 TestType Platform class_type TestCase" 
 exit 1
fi

#-------------------------------------------------------
TestType="$1"
Platform="$2"
class_type="$3"
TestCase="$4"
#-------------------------------------------------------

#-------------------------------------------------------------------------
#初始化变量
#-------------------------------------------------------------------------
#dirList_file="${destPath}/HistoryDirList.file"
#---------------------------------------------------


#浮点型测试
python make_spec2000_1core_history_html.py $TestType $Platform $class_type "spec2000-1core_CFP"

#整型测试
python make_spec2000_1core_history_html.py $TestType $Platform $class_type "spec2000-1core_CINT"
