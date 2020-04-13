#!/bin/bash

#---------------------------------------------------
#对于性能跑分历史测试结果进行提取和存储，
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

#-------------------------------------------------------------------------
#初始化变量
#-------------------------------------------------------------------------
#dirList_file="${destPath}/HistoryDirList.file"
#---------------------------------------------------


#遍历所有历史版本中的测试用例结果并写入文件
count_items=$(cat ../../../Common/node_count.cfg)
echo count_items is:$count_items 


for((i=1;i<=count_items;i++));
do
       #每次循环都会将同一历史版本的所有字段写入文件
       NodeNum=$i
       #记录历史结果到一个文件中
       python history_spec2000_1core_CINT_csv2html.py $TestType $Platform $class_type $NodeNum
done
