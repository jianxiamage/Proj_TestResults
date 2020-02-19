#!/bin/bash

if [ $# -ne 1 ];then
  cmdStr="usage:$0 TestType"
  echo $cmdStr
  exit 1
fi

#-----------------------------------------------------
TestType=$1
srcResultFile="TestResults_${TestType}.ini"
descIniFile="TestResults.ini"
#-----------------------------------------------------


ResultPath='/data'
ResultIniFile=$srcResultFile
echo srcFile:$ResultIniFile

destPath=''

#rm -rf /data

mkdir $ResultPath/$TestType -p

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

echo "----------------------------------------------------"

for item_plat in ${Platform[@]}; do

  #echo 当前平台:$item_plat
  
  destPath="${ResultPath}/${TestType}/${item_plat}"
  mkdir $destPath -p
  destResultFile="${ResultPath}/${TestType}/${item_plat}/${descIniFile}"
  echo destResultFile:$destResultFile
 
  \cp $srcResultFile $destResultFile -f

done

echo "----------------------------------------------------"
