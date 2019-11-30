#!/bin/bash

#!/bin/bash
set -e

if [ $# -ne 3 ];then
 echo "usage: $0 TestType Platform Proj_Name" 
 exit 1
fi

#----------------------------------------------------------------------------------------
TestType=$1
Platform=$2
Proj_Name=$3
#----------------------------------------------------------------------------------------
ResultPath='/data'
#----------------------------------------------------------------------------------------

cur_path=$(cd `dirname $0`; pwd)
#project_name="${project_path##*/}"
echo "The current path is:"
echo $cur_path

echo "-------------------------------------------------"

echo Project Name:$Proj_Name
echo TestType:$TestType
echo Platform:$Platform

pro_dir="${Proj_Name}_${TestType}_${Platform}"

echo $TestType > ${pro_dir}/test_type.txt
echo $Platform > ${pro_dir}/test_plat.txt

#将TestResults.ini文件路径作为一个文件,写入到测试报告项目的testcase目录下
#/data/OS/7A/TestResults.ini
dest_path='testcase'
dest_file='testResultIni_path.txt'
ini_filename='TestResults.ini'
file_path="${cur_path}/${Proj_Name}_${TestType}_${Platform}/${dest_path}/${dest_file}"
file_content="${ResultPath}/${TestType}/${Platform}/${ini_filename}"

echo file_path:$file_path
echo file_content:$file_content

echo $file_content > $file_path
