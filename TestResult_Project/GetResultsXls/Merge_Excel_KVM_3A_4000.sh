#!/bin/bash

#if [ $# -ne 3 ];then
# echo "usage: $0 TestType Platform TestCase" 
# exit 1
#fi

#----------------------------------------------------------------------------------------
TestType="KVM"
Platform="3A_4000"
#----------------------------------------------------------------------------------------

sh merge_Excel_Case_all.sh $TestType $Platform "iozone"

sh merge_Excel_Case_all.sh $TestType $Platform "stream"

sh merge_Excel_Case_all.sh $TestType $Platform "SpecJvm2008"

sh merge_Excel_Case_all.sh $TestType $Platform "UnixBench"

sh merge_Excel_Case_all.sh $TestType $Platform "spec2000-1core"

sh merge_Excel_Case_all.sh $TestType $Platform "spec2000-ncore"

sh merge_Excel_Case_all.sh $TestType $Platform "spec2006-1core"

sh merge_Excel_Case_all.sh $TestType $Platform "spec2006-ncore"
