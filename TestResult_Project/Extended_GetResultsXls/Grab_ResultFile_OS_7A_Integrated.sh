#!/bin/bash
set -e

#if [ $# -ne 3 ];then
# echo "usage: $0 TestType Platform TestCase" 
# exit 1
#fi

#----------------------------------------------------------------------------------------
TestType="OS"
Platform="7A_Integrated"
#----------------------------------------------------------------------------------------

echo "开始获取测试结果跑分文件:[$TestType],[$Platform]"

sh get_result_tag.sh $TestType $Platform "iozone"

sh get_result_tag.sh $TestType $Platform "stream"

sh get_result_tag.sh $TestType $Platform "SpecJvm2008"

sh get_result_tag.sh $TestType $Platform "UnixBench"

sh get_result_tag.sh $TestType $Platform "spec2000-1core"

sh get_result_tag.sh $TestType $Platform "spec2000-ncore"

sh get_result_tag.sh $TestType $Platform "spec2006-1core"

sh get_result_tag.sh $TestType $Platform "spec2006-ncore"

echo "获取测试结果跑分文件成功结束:[$TestType],[$Platform]"
