#!/bin/bash


resultsPath=$(cat data_path.txt)

Excel_Merge_Path='merge_Excel'
Excel_Results_Path='Results_Excel'

destPath=''

#mkdir $resultsPath -p

TestType=("OS" "Kernel" "KVM")
i=1
for item_type in ${TestType[@]}; do

    echo ----------------------------------------------------
    echo 当前平台:$item_plat
    
    destPath_Merge="${resultsPath}/${item_type}/${Excel_Merge_Path}"
    mkdir $destPath_Merge -p
    echo "Create directory:$destPath_Merge End."


    destPath_Results="${resultsPath}/${item_type}/${Excel_Results_Path}"
    mkdir $destPath_Results -p
    echo "Create directory:$destPath_Results End."
 
    let i++
    

done

echo ----------------------------------------------------

