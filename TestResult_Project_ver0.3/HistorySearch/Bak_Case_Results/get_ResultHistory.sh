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
#-------------------------------------------------------------------------
searchDir="Search"
ResultsDir="caseResults"
srcPath="${web_Path}/${class_type}/${history_Dir}/${Platform}/${TestType}"
destPath="${web_Path}/${class_type}/${searchDir}/${Platform}/${TestType}"
Results_destPath="${destPath}/${ResultsDir}"
case_destPath="${Results_destPath}/${TestCase}"
#-------------------------------------------------------------------------
mkdir $destPath -p
mkdir $Results_destPath -p
mkdir $case_destPath -p
#---------------------------------------------------
dirList_file="${destPath}/HistoryDirList.file"
#---------------------------------------------------

#--------------------------------
source ./ini_operation.sh
readIni=$readIni
#--------------------------------


#从历史版本文件读入到List，逐个进行目录拼接
echo "*********************************************"
echo "遍历历史记录目录:"
Dir_List=($(cat $dirList_file))

for element in ${Dir_List[@]}
do
    #echo $element
    history_path=$srcPath/$element
    echo $history_path
done

echo "*********************************************"


#遍历所有历史版本中的测试用例结果并写入文件
count_items=$(cat node_count.cfg)
echo count_items is:$count_items 


for((i=1;i<=count_items;i++));
do
  echo "[History]" > ${case_destPath}/${TestCase}_${i}.file
  for item in ${Dir_List[@]}
  do
       #拼接测试结果文件路径
       history_resultFile=$srcPath/$item/${resultsFile}
       #echo "history_resultFile:${history_resultFile}"
       NodeNum=$i
       sectionName="iozone"
       keyName="node_${i}"
       #echo "第[$i] 个keyName:$keyName"
       keyVal=$(readIni $history_resultFile $sectionName $keyName)
       echo "case->[iozone],Ver->[${item}]node->[${i}],result->[${keyVal}]"
       #记录历史结果到一个文件中
       echo "${item} = ${keyVal}" >> ${case_destPath}/${TestCase}_${i}.file
  done
done

