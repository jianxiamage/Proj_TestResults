#!/bin/bash


srcGroupFile='TestcaseGroup.ini'

resultsPath=$(cat data_path.txt)
#GroupIniFile=$srcGroupFile
echo copy the [$srcGroupFile] to dest Dir

destPath=''

mkdir $resultsPath -p

TestType=("OS" "Kernel" "KVM")
i=1
for item_type in ${TestType[@]}; do

    echo ----------------------------------------------------
    echo 这是第$i个ini文件
    #echo 当前平台:$item_plat
    
    destPath="${resultsPath}/${item_type}"
    mkdir $destPath -p
    destGroupFile="${resultsPath}/${item_type}/"
    echo destGroupFile:$destGroupFile
 
    srcGroupFile="TestcaseGroup_${item_type}.ini"
    echo the srcGroupFile is:$srcGroupFile
    \cp $srcGroupFile $destGroupFile -f
    let i++
    

done

echo ----------------------------------------------------

