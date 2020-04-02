#!/bin/bash

#---------------------------------------------------
#跑分测试用例的历史测试结果进行提取和存储
#---------------------------------------------------

#验证参数个数
if [ $# -ne 4 ];then
 echo "usage: $0 TestType Platform class_type TestMode" 
 exit 1
fi

#-------------------------------------------------------
TestType="$1"
Platform="$2"
class_type="$3"
TestMode="$4"
#-------------------------------------------------------

#-------------------------------------------------------------------------
#初始化变量
#-------------------------------------------------------------------------
#dirList_file="${destPath}/HistoryDirList.file"
#---------------------------------------------------


#遍历所有历史版本中的测试用例结果并写入文件
count_items=$(cat ../../Common/node_count.cfg)
echo count_items is:$count_items 

#UnixBench跑分情况：
#共13种情况，除最后一项:System Benchmarks Index Score之外,都有三类:(BASELINE,RESULT,INDEX)
#最后一项:System Benchmarks Index Score只有一种结果
for((i=1;i<=count_items;i++));
do
       #每次循环都会将同一历史版本的所有字段写入文件
       NodeNum=$i
       #记录历史结果到一个文件中
       python history_UnixBench_part_2csv.py $TestType $Platform $class_type $TestMode "BASELINE" $NodeNum
       python history_UnixBench_part_2csv.py $TestType $Platform $class_type $TestMode "RESULT" $NodeNum
       python history_UnixBench_part_2csv.py $TestType $Platform $class_type $TestMode "INDEX" $NodeNum
       python history_UnixBench_Benchmarks_2csv.py $TestType $Platform $class_type $TestMode "Benchmarks" $NodeNum
done
