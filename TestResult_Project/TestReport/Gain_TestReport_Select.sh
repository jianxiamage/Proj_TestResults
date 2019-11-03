#!/bin/bash

if [ $# -ne 2 ];then
 echo "usage: $0 TestType Platform" 
 exit 1
fi

TestType=$1
Platform=$2

echo "Begin to get result report.TestType:[$TestType],TestPlat:[$Platform]"
Gain_TestReport="Gain_TestReport_${TestType}_${Platform}"
sh ${Gain_TestReport}.sh

