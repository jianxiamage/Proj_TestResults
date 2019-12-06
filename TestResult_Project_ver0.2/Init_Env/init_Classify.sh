#!/bin/bash

#----------------------------------------------------
srcGroupFile='TestcaseGroup.ini'
ResultPath='/Results'
#GroupIniFile=$srcGroupFile
#echo copy the [$srcGroupFile] to dest Dir
#----------------------------------------------------
destPath=$ResultPath
BakPath=History_Bak
#----------------------------------------------------

echo "Init the Classification Path End."

mkdir $ResultPath -p

ClassType=("PC" "Server" "KVM")
i=1
for item_type in ${ClassType[@]}; do

    echo "----------------------------------------------------"
    echo 这是第$i个分类目录:$item_type
    #echo 当前分类:$item_plat
    
    mkdir $destPath/${item_type}/${BakPath} -p
    #destPath="${ResultPath}/${item_type}"
    #destGroupFile="${ResultPath}/${item_type}/"
    #echo destGroupFile:$destGroupFile
    #\cp $srcGroupFile $destGroupFile -f

    let i++

done

echo "----------------------------------------------------"

#将测试用例分组文件放入目标目录下，便于查看
echo "Begin to copy the group file for the test cases..."
\cp $srcGroupFile $ResultPath -f
echo "Copy the group file for the test cases End."

echo ----------------------------------------------------
echo "Init the Classification Path End."
