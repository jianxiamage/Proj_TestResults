#!/bin/bash
set -e

if [ $# -ne 3 ];then
 echo "usage: $0 TestType Platform TestCase" 
 exit 1
fi
#----------------------------------------------------------------------------------------
TestType="$1"
Platform="$2"
TestCase="$3"
#----------------------------------------------------------------------------------------


python -c 'import merge_Excel_Case; merge_Excel_Case.mergeTestExcel("'$TestType'","'$Platform'","'$TestCase'")'
