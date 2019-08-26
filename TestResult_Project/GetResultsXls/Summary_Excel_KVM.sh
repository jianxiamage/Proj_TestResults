#!/bin/bash
set -e

#if [ $# -ne 3 ];then
# echo "usage: $0 TestType Platform TestCase" 
# exit 1
#fi

#----------------------------------------------------------------------------------------
TestType="KVM"
#Platform="7A"
#----------------------------------------------------------------------------------------

Platform="7A"
sh summary_Excel_Results_all.sh $TestType $Platform

Platform="7A_Integrated"
sh summary_Excel_Results_all.sh $TestType $Platform

Platform="7A_2way"
sh summary_Excel_Results_all.sh $TestType $Platform

Platform="780"
sh summary_Excel_Results_all.sh $TestType $Platform

Platform="2K"
sh summary_Excel_Results_all.sh $TestType $Platform

