#!/bin/bash

if [ $# -ne 2 ];then
 echo "usage: $0 TestType Platform" 
 exit 1
fi

TestType=$1
Platform=$2

echo "Begin to download result files.TestType:[$TestType],TestPlat:[$Platform]"
Grab_ResultFileName="Grab_ResultFile_${TestType}_${Platform}"
sh ${Grab_ResultFileName}.sh

echo "Begin to make result files by ini format.TestType:[$TestType],TestPlat:[$Platform]"
Make_Result_Ini="Make_Result_Ini_${TestType}_${Platform}"
sh ${Make_Result_Ini}.sh

echo "Begin to create Performance test run points files by Excel.TestType:[$TestType],TestPlat:[$Platform]"
Create_Result_Excel="Create_Result_Excel_${TestType}_${Platform}"
sh ${Create_Result_Excel}.sh

echo "Begin to merge Performance test run points files by Excel for each test case.TestType:[$TestType],TestPlat:[$Platform]"
Merge_Excel="Merge_Excel_${TestType}_${Platform}"
sh ${Merge_Excel}.sh

echo "Begin to summary Performance test run points files by Excel for all the performance test cases.TestType:[$Kernel],TestPlat:[$Platform]"
Summary_Excel="Summary_Excel_${TestType}_${Platform}"
sh ${Summary_Excel}.sh
