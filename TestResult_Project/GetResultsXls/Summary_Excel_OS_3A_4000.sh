#!/bin/bash
set -e

#if [ $# -ne 3 ];then
# echo "usage: $0 TestType Platform TestCase" 
# exit 1
#fi

#----------------------------------------------------------------------------------------
TestType="OS"
Platform="3A_4000"
#----------------------------------------------------------------------------------------

sh summary_Excel_Results_all.sh $TestType $Platform
