#!/bin/bash

#----------------------------------------------------------------------------------------
if [ $# -ne 2 ];then
 echo "usage: $0 TestType Platform" 
 exit 1
fi
#----------------------------------------------------------------------------------------
TestType="$1"
Platform="$2"
#class_type="$3"
TestCase="UnixBench"
#----------------------------------------------------------------------------------------

#----------------------------------------------------------------------------
#判断测试分类
class_type=`sh ../../../Common/grab_TestTag.sh $TestType $Platform "ClassifyType"`
echo "class_type:$class_type"
#----------------------------------------------------------------------------


#检查当前的测试平台含有的线程数
sh check_threadNum_UnixBench.sh $TestType $Platform $class_type


#生成性能测试历史记录查看主页
#用户可在此主页中选择指定分类进行历史查看
python make_Index_history_html.py $TestType $Platform $class_type

