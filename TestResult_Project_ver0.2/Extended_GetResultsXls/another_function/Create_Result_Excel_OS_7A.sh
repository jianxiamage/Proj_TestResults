#!/bin/bash

#未做异常控制的原因:
#每个测试用例生成Excel功能成功与否不能影响其他测试用例继续进行生成Excel
#即每次执行本脚本,所有需要生成测试结果Excel的测试用例都会扫描一次
#if [ $# -ne 3 ];then
# echo "usage: $0 TestType Platform TestCase" 
# exit 1
#fi

#----------------------------------------------------------------------------------------
TestType="OS"
Platform="7A"
#----------------------------------------------------------------------------------------

sh create_Excel_Points_all.sh $TestType $Platform "iozone"

sh create_Excel_Points_all.sh $TestType $Platform "stream"

sh create_Excel_Points_all.sh $TestType $Platform "SpecJvm2008"

sh create_Excel_Points_all.sh $TestType $Platform "UnixBench"

sh create_Excel_Points_all.sh $TestType $Platform "spec2000-1core"

sh create_Excel_Points_all.sh $TestType $Platform "spec2000-ncore"

sh create_Excel_Points_all.sh $TestType $Platform "spec2006-1core"

sh create_Excel_Points_all.sh $TestType $Platform "spec2006-ncore"
