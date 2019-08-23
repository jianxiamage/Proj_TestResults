#!/bin/bash

#if [ $# -ne 3 ];then
# echo "usage: $0 TestType Platform TestCase" 
# exit 1
#fi

#----------------------------------------------------------------------------------------
TestType="OS"
Platform="7A_2way"
#----------------------------------------------------------------------------------------

sh create_Excel_Points_all.sh $TestType $Platform "iozone"

sh create_Excel_Points_all.sh $TestType $Platform "stream"

sh create_Excel_Points_all.sh $TestType $Platform "SpecJvm2008"

sh create_Excel_Points_all.sh $TestType $Platform "UnixBench"

sh create_Excel_Points_all.sh $TestType $Platform "spec2000-1core"

sh create_Excel_Points_all.sh $TestType $Platform "spec2000-ncore"

sh create_Excel_Points_all.sh $TestType $Platform "spec2006-1core"

sh create_Excel_Points_all.sh $TestType $Platform "spec2006-ncore"
