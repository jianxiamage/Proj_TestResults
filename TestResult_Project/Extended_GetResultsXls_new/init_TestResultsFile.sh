#!/bin/bash

#/data-std/TestResults.ini

srcResultFile='TestResults.ini'
IPListFile='ip_list.ini'

resultsPath=$(cat data_path.txt)
ResultIniFile=$srcResultFile
echo srcFile:$ResultIniFile

destPath=''

mkdir $resultsPath -p

TestType=("OS" "Kernel" "KVM")

Platform=("7A" "7A_Integrated" "7A_2way" "780" "2K")

for item_type in ${TestType[@]}; do

  #echo $item_type
  echo ----------------------------------------------------

  for item_plat in ${Platform[@]}; do

    #echo 当前平台:$item_plat
    
    destPath="${resultsPath}/${item_type}/${item_plat}"
    mkdir $destPath -p
    destResultFile="${resultsPath}/${item_type}/${item_plat}/${srcResultFile}"
    #destIPListFile="${resultsPath}/${item_type}/${item_plat}/${IPListFile}"
    echo destResultFile:$destResultFile
    #echo destIPListFile:$destIPListFile
 
    \cp $srcResultFile $destResultFile -f

  done

done

echo ----------------------------------------------------

