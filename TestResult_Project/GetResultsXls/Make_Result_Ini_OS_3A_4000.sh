#!/bin/bash

#if [ $# -ne 3 ];then
# echo "usage: $0 TestType Platform TestCase" 
# exit 1
#fi

#----------------------------------------------------------------------------------------
TestType="OS"
Platform="3A_4000"
#----------------------------------------------------------------------------------------

sh make_Ini_Points_all.sh $TestType $Platform "iozone"

sh make_Ini_Points_all.sh $TestType $Platform "stream"

sh make_Ini_Points_all.sh $TestType $Platform "SpecJvm2008"

sh make_Ini_Points_all.sh $TestType $Platform "UnixBench"

sh make_Ini_Points_all.sh $TestType $Platform "spec2000-1core"

sh make_Ini_Points_all.sh $TestType $Platform "spec2000-ncore"

sh make_Ini_Points_all.sh $TestType $Platform "spec2006-1core"

sh make_Ini_Points_all.sh $TestType $Platform "spec2006-ncore"
