#!/bin/bash

if [ $# -ne 1 ];then
  cmdStr="usage:$0 TestType"
  echo $cmdStr
  exit 1
fi

#-----------------------------------------------------
TestType=$1
srcResultFile="TestResults.ini"
#-----------------------------------------------------

ResultPath='/data'
ResultIniFile=$srcResultFile
echo srcFile:$ResultIniFile

destPath=''

#rm -rf /data

mkdir $ResultPath/$TestType -p

#TestType=("OS" "Kernel" "KVM")

Platform=("7A" "7A_Integrated" "7A_2way" "780" "2K")

echo ----------------------------------------------------

for item_plat in ${Platform[@]}; do

  #echo 当前平台:$item_plat
  
  destPath="${ResultPath}/${TestType}/${item_plat}"
  mkdir $destPath -p
  destResultFile="${ResultPath}/${TestType}/${item_plat}/${srcResultFile}"
  echo destResultFile:$destResultFile
 
  \cp $srcResultFile $destResultFile -f

done


echo ----------------------------------------------------

