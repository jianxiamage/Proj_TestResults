#!/bin/bash

if [ $# -ne 1 ];then
  cmdStr="usage:$0 TestType"
  echo $cmdStr
  exit 1
fi

#-----------------------------------------------------
TestType=$1
#-----------------------------------------------------
ResultPath='/data'

Excel_Merge_Path='merge_Excel'
Excel_Results_Path='Results_Excel'

destPath=''

#mkdir $ResultPath/$TestType -p

#TestType=("OS" "Kernel" "KVM")

#--------------------------------------------------------------
#Platform=("7A" "7A_Integrated" "7A_2way" "780" "2K" "3A_4000")
#为便于添加新平台，可以将平台名写入文件中，由程序读取到数组中
#--------------------------------------------------------------
PlatformFile=../Common_Func/PlatformList.txt
echo platform file:$PlatformFile
if [ ! -f "$PlatformFile" ]
then
  echo "$PlatformFile is not exists,Please check it!"
  exit 1
fi

declare -a Platform
Platform=($(cat $PlatformFile))
#--------------------------------------------------------------


echo ----------------------------------------------------

for item_type in ${Platform[@]}; do

    echo ----------------------------------------------------
    echo 当前平台:$item_type

    destPath_Merge="${ResultPath}/${TestType}/${item_type}/${Excel_Merge_Path}"
    mkdir $destPath_Merge -p
    echo "Create directory:$destPath_Merge End."


    destPath_Results="${ResultPath}/${TestType}/${item_type}/${Excel_Results_Path}"
    mkdir $destPath_Results -p
    echo "Create directory:$destPath_Results End." 

done


echo ----------------------------------------------------

