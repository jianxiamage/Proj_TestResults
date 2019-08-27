#!/bin/bash

#if [ $# -ne 3 ];then
# echo "usage: $0 TestType Platform TestCase" 
# exit 1
#fi

#----------------------------------------------------------------------------------------
TestType="KVM"
Platform="7A_2way"
#----------------------------------------------------------------------------------------

sh summary_Excel_Results_all.sh $TestType $Platform
