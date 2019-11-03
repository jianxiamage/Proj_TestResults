#!/bin/bash

if [ $# -ne 2 ];then
 echo "usage: $0 TestType Platform" 
 exit 1
fi

TestType=$1
Platform=$2

echo "Begin to download result files.TestType:[$TestType],TestPlat:[$Platform]"
Get_OSInfo="Get_OSInfo_${TestType}_${Platform}"
sh ${Get_OSInfo}.sh
