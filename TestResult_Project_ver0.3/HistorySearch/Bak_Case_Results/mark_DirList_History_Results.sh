#!/bin/bash

#--------------------------------
#脚本功能:
#历史记录目录列表写入文件
#--------------------------------

if [ $# -ne 2 ];then
 echo "usage: $0 TestType Platform" 
 exit 1
fi

#--------------------------------
source ./ini_operation.sh
readIni=$readIni
#--------------------------------

#-------------------------------------------------------
TestType="$1"
Platform="$2"
#-------------------------------------------------------
#-------------------------------------------------------
resultsPath="/data"
web_Path="/Results"
history_Dir="History_Bak"
#-------------------------------------------------------

#----------------------------------------------------------------------------
class_type=`sh ../Common/grab_TestTag.sh $TestType $Platform "ClassifyType"`
echo "class_type:$class_type"

Tag="${class_type}_${Platform}_${TestType}"
test_type=`sh ../Common/grab_TestTag.sh $TestType $Platform "TestType"`
echo "test_type:$test_type"

test_plat=`sh ../Common/grab_TestTag.sh $TestType $Platform "Platform"`
echo "test_plat:$test_plat"
#----------------------------------------------------------------------------

name_Tag=''

case ${TestType} in

    "OS")

        OS_Ver=`sh ../Common/grab_TestTag.sh $TestType $Platform "OS_Ver"`
        echo "OS Version:$OS_Ver"
        name_Tag=$OS_Ver
        
        ;;
    "Kernel")

        Kernel_Ver=`sh ../Common/grab_TestTag.sh $TestType $Platform "Kernel_Ver"`
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
destPath="${web_Path}/${class_type}/${searchDir}/${Platform}/${TestType}"
#-----------------------------------------------------------------------------
#rm -rf $destPath
mkdir $destPath -p
#-----------------------------------------------------------------------------
dirList_file="${destPath}/HistoryDirList.file"
rm -rf $dirList_file
#----------------------------------------------------
echo "*********************************************"
echo "历史记录目录:"
echo "srcPath:${srcPath}"
#/Results/Server/History_Bak/7A_2way/OS/20192001-RC1.mips64

#----------------------------------------------------
#查找历史记录文件夹，将所有版本名称写入文件备用
echo "*********************************************"
echo "将历史记录目录名称写入文件存储"
echo "------------------------------------------------"
for dir in $(ls $srcPath)
do  
    #先判断是否是目录，然后再输出
    [ -d ${srcPath}/$dir ] && echo $dir || continue
    echo "${dir}" >> $dirList_file
done
echo "------------------------------------------------"
#----------------------------------------------------
