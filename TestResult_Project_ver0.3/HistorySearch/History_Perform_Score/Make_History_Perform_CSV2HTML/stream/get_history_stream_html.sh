#!/bin/bash

#---------------------------------------------------
#对每个性能跑分历史测试结果进行提取和存储，
#便于程序查看每个指定测试用例的所有历史测试记录
#---------------------------------------------------

#验证参数个数
if [ $# -ne 3 ];then
 echo "usage: $0 TestType Platform class_type" 
 exit 1
fi

#-------------------------------------------------------
TestType="$1"
Platform="$2"
class_type="$3"
#-------------------------------------------------------

#stream 单核测试 写csv文件
sh get_history_stream_1core_html.sh $TestType $Platform $class_type

#stream 多核测试 写csv文件
sh get_history_stream_ncore_html.sh $TestType $Platform $class_type

