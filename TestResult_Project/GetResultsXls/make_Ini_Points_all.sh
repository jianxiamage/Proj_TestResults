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
echo --------------------------------------------------------------------------------
echo "写入测试结果跑分到Excel文件..."
echo "当前路径:"
pwd 
echo --------------------------------------------------------------------------------

#There are many branches for test cases in judgment.So use case mode...
case $TestCase in
"iozone")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    sh get_score_2config_iozone.sh $TestType $Platform $TestCase
    echo --------------------------------------------------------------------------------
    ;;

"netperf")
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    ;;

"lmbench")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    echo --------------------------------------------------------------------------------
    ;;

"stream")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr

    #stream单核测试
    sh get_score_2config_stream_all.sh $TestType $Platform $TestCase

    echo --------------------------------------------------------------------------------
    ;;

"UnixBench")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    
    #UnixBench在不同机器上执行不同的线程脚本，会生成不同的测试结果文件，因此需要判断后执行
    sh judge_UnixBench_IniFile.sh $TestType $Platform
    #echo --------------------------------------------------------------------------------
    ;;

"spec2000-1core")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    
    #spec2000单核浮点型及整型测试结果
    sh get_score_2config_spec2000_1core_all.sh $TestType $Platform $TestCase

    echo --------------------------------------------------------------------------------
    ;;

"spec2000-ncore")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr

    #spec2000多核浮点型及整型测试结果
    sh get_score_2config_spec2000_ncore_all.sh $TestType $Platform $TestCase

    echo --------------------------------------------------------------------------------
    ;;

"spec2006-1core")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr

    #spec2006单核浮点型及整型测试结果
    sh get_score_2config_spec2006_1core_all.sh $TestType $Platform $TestCase

    echo --------------------------------------------------------------------------------
    ;;

"spec2006-ncore")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr

    #spec2000多核浮点型及整型测试结果
    sh get_score_2config_spec2006_ncore_all.sh $TestType $Platform $TestCase

    echo --------------------------------------------------------------------------------
    ;;

"SpecJvm2008")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr

    #SpecJvm2008测试
    #sh create_Excel_Points_SpecJvm2008.sh $TestType $Platform $TestCase
    sh get_score_2config_SpecJvm2008.sh $TestType $Platform $TestCase

    echo --------------------------------------------------------------------------------
    ;;

*)
    cmdStr="Error:UnSupport this Testcase:$Testcase.Please check it!"
    echo $cmdStr
    exit 1
    ;;
esac

echo [$TestCase] write results as Ini File successfully!
echo --------------------------------------------------------------------------------
