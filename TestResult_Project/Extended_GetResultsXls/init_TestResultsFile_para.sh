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

resultsPath=$(cat data_path.txt)
ResultIniFile=$srcResultFile
echo srcFile:$ResultIniFile

destPath=''

#rm -rf /data

mkdir $resultsPath/$TestType -p

#TestType=("OS" "Kernel" "KVM")

Platform=("7A" "7A_Integrated" "7A_2way" "780" "2K")

echo ----------------------------------------------------

for item_plat in ${Platform[@]}; do

  #echo 当前平台:$item_plat
  
  destPath="${resultsPath}/${TestType}/${item_plat}"
  mkdir $destPath -p
  destResultFile="${resultsPath}/${TestType}/${item_plat}/${srcResultFile}"
  echo destResultFile:$destResultFile
 
  \cp $srcResultFile $destResultFile -f

done


echo ----------------------------------------------------

