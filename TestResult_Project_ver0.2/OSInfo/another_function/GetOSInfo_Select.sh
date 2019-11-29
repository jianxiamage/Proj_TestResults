#!/bin/bash

if [ $# -ne 2 ];then
 echo "usage: $0 TestType Platform" 
 exit 1
fi

TestType=$1
Platform=$2

echo "Begin to set result files.TestType:[$TestType],TestPlat:[$Platform]"
GetOSInfoFile="GetOSInfo_${TestType}_${Platform}"
sh ${GetOSInfoFile}.sh

