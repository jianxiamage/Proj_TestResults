#!/bin/bash

#---------------------------------------------------
#对每个测试用例的历史测试结果进行提取和存储，
#便于程序查看每个指定测试用例的所有历史测试记录
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
resultsPath="/data"
web_Path="/Results"
history_Dir="History_Bak"
resultsFile="TestResults.ini"
detail_path="Detail"
points_path="Points_Files"
#-------------------------------------------------------------------------
searchDir="Search"
ResultsDir="performScore"
srcPath="${web_Path}/${class_type}/${history_Dir}/${Platform}/${TestType}/${detail_path}/${TestCase}/${points_path}"
destPath="${web_Path}/${class_type}/${Platform}/${TestType}/${searchDir}"
Results_destPath="${destPath}/${ResultsDir}"
case_destPath="${Results_destPath}/${TestCase}"
#-------------------------------------------------------------------------
#rm -rf $destPath
mkdir $destPath -p
mkdir $Results_destPath -p
mkdir $case_destPath -p
#-------------------------------------------------------------------------

#----------------------------------------------------------------------------------------
#使用python虚拟环境执行命令
export WORKON_HOME=/home/work/env-wrapper

echo ---------------------------------
echo 'active the virtualenvwrapper'
echo ---------------------------------
source /usr/bin/virtualenvwrapper.sh

echo ---------------------------------
echo 'change to virtualenv:env-database'
echo ---------------------------------
workon env-database

echo "Begin to  to csv file..."

#---------------------------------------------------
dirList_file="${destPath}/HistoryDirList.file"
#---------------------------------------------------


#遍历所有历史版本中的测试用例结果并写入文件
count_items=$(cat node_count.cfg)
echo count_items is:$count_items 


for((i=1;i<=count_items;i++));
do
       #每次循环都会将同一历史版本的所有字段写入文件
       NodeNum=$i
       #记录历史结果到一个文件中
       python history_iozone_2csv.py $TestType $Platform $class_type $TestCase $NodeNum
done

