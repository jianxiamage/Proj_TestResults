#!/bin/bash
set -e

if [ $# -ne 2 ];then
 echo "usage: $0 TestType Platform" 
 exit 1
fi
#----------------------------------------------------------------------------------------
TestType="$1"
Platform="$2"
#----------------------------------------------------------------------------------------


python -c 'import summary_Excel_Results; summary_Excel_Results.summaryExcel("'$TestType'","'$Platform'")'
