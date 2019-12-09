#!/bin/bash

#!/bin/bash
set -e

if [ $# -ne 1 ];then
 echo "usage: $0 FileName" 
 exit 1
fi

#----------------------------------------------------------------------------------------
TestType="OS"
Platform="7A"
#----------------------------------------------------------------------------------------
ResultPath='/data'
#----------------------------------------------------------------------------------------

cur_path=$(cd `dirname $0`; pwd)
#project_name="${project_path##*/}"
echo "The current path is:"
echo $cur_path

FileName=$1
echo $curFileName

file_basename="${FileName%.*}"
echo $file_basename

echo "-------------------------------------------------"

Proj_Name=`echo "$file_basename" | awk -F'_' '{print $2}'`
TestType=`echo "$file_basename" | awk -F'_' '{print $3}'`
Platform=`echo "$file_basename" | awk -F'_' '{print $4}'`

echo Project Name:$Proj_Name
echo TestType:$TestType
echo Platform:$Platform

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
