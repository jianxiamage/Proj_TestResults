#!/bin/bash

#--------------------------------
#脚本功能:
#历史记录目录列表写入文件
#--------------------------------

if [ $# -ne 3 ];then
 echo "usage: $0 TestType Platform TestCase" 
 exit 1
fi

#--------------------------------
source ./ini_operation.sh
readIni=$readIni
#--------------------------------

#-------------------------------------------------------
TestType="$1"
Platform="$2"
TestCase="$3"
#-------------------------------------------------------
#-------------------------------------------------------
resultsPath="/data"
web_Path="/Results"
history_Dir="History_Bak"
#-------------------------------------------------------

#----------------------------------------------------------------------------
class_type=`sh ../../Common/grab_TestTag.sh $TestType $Platform "ClassifyType"`
echo "class_type:$class_type"

Tag="${class_type}_${Platform}_${TestType}"
test_type=`sh ../../Common/grab_TestTag.sh $TestType $Platform "TestType"`
echo "test_type:$test_type"

test_plat=`sh ../../Common/grab_TestTag.sh $TestType $Platform "Platform"`
echo "test_plat:$test_plat"
#----------------------------------------------------------------------------

name_Tag=''

case ${TestType} in

    "OS")

        OS_Ver=`sh ../../Common/grab_TestTag.sh $TestType $Platform "OS_Ver"`
        echo "OS Version:$OS_Ver"
        name_Tag=$OS_Ver
        
        ;;
    "Kernel")

        Kernel_Ver=`sh ../../Common/grab_TestTag.sh $TestType $Platform "Kernel_Ver"`
        echo "Kernel Version:$Kernel_Ver"
        name_Tag=$Kernel_Ver

        ;;

    "KVM")

        echo "test_type:$test_type"

        ;;
    *)
        echo "Not support the current class Type:${class_type}"
        exit 1
        ;;
esac

#------------------------------------------------------------------
echo "---------------------------------------"
echo "---------参数列表----------------"
echo "class_type:${class_type}"
echo "TestType:${TestType}"
echo "Platform:${Platform}"
echo "Tag:${Tag}"
echo "name_Tag:${name_Tag}"
echo "---------------------------------------"
#------------------------------------------------------------------
#开始备份测试结果历史版本

#-----------------------------------------------------------------------------
searchDir="Search"
srcPath="${web_Path}/${class_type}/${history_Dir}/${Platform}/${TestType}"
#destPath="${web_Path}/${class_type}/${searchDir}/${Platform}/${TestType}"
destPath="${web_Path}/${class_type}/${Platform}/${TestType}/${searchDir}"
#-----------------------------------------------------------------------------
#----------------------------------------------------
echo "*********************************************"

#----------------------------------------------------
#生成测试用例历史记录html文件
echo "*********************************************"
echo "将历史记录html文件写入文件存储"
echo "------------------------------------------------"
count_items=$(cat node_count.cfg)
echo count_items is:$count_items 

for((i=1;i<=count_items;i++));
do
  NodeNum=$i
  #python make_history_html.py OS 7A_2way Server iozone 1
  python make_history_html.py $TestType $Platform $class_type $TestCase $NodeNum 

done
echo "------------------------------------------------"
#----------------------------------------------------
