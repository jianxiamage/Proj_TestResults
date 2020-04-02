#!/bin/bash

if [ $# -ne 3 ];then
 echo "usage: $0 TestType Platform TestCase" 
 exit 1
fi
#----------------------------------------------------------------------------------------
TestType="$1"
Platform="$2"
TestCase="$3"
#----------------------------------------------------------------------------------------
retCode=0
#----------------------------------------------------------------------------------------
echo --------------------------------------------------------------------------------
echo "转换性能测试跑分ini文件为csv文件..."
echo "当前路径:"
pwd 
echo --------------------------------------------------------------------------------

#----------------------------------------------------------------------------
class_type=`sh ../Common/grab_TestTag.sh $TestType $Platform "ClassifyType"`
echo "class_type:$class_type"
#----------------------------------------------------------------------------


#---------------------------------------------------
#进入测试用例目录
pushd ${TestCase}
#---------------------------------------------------

#There are many branches for test cases in judgment.So use case mode...
case $TestCase in
"iozone")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    sh get_history_iozone.sh $TestType $Platform $class_type
    retCode=$?
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
    sh get_history_stream.sh $TestType $Platform $class_type
    retCode=$?

    echo --------------------------------------------------------------------------------
    ;;

"UnixBench")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    
    #UnixBench在不同机器上执行不同的线程脚本，会生成不同的测试结果文件，因此需要判断后执行
    sh judge_UnixBench_history_csvFile.sh $TestType $Platform $class_type
    retCode=$?
    #echo --------------------------------------------------------------------------------
    ;;

"spec2000-1core")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    
    #spec2000单核浮点型及整型测试结果
    sh get_history_spec2000_1core.sh $TestType $Platform $class_type
    retCode=$?

    echo --------------------------------------------------------------------------------
    ;;

"spec2000-ncore")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr

    #spec2000多核浮点型及整型测试结果
    sh get_history_spec2000_ncore.sh $TestType $Platform $class_type
    retCode=$?

    echo --------------------------------------------------------------------------------
    ;;

"spec2006-1core")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr

    #spec2006单核浮点型及整型测试结果
    sh get_history_spec2006_1core.sh $TestType $Platform $class_type
    retCode=$?

    echo --------------------------------------------------------------------------------
    ;;

"spec2006-ncore")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr

    #spec2000多核浮点型及整型测试结果
    sh get_history_spec2006_ncore.sh $TestType $Platform $class_type
    retCode=$?

    echo --------------------------------------------------------------------------------
    ;;

"SpecJvm2008")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    #SpecJvm2008测试
    sh get_history_SpecJvm2008.sh $TestType $Platform $class_type
    retCode=$?

    echo --------------------------------------------------------------------------------
    ;;

*)
    cmdStr="Error:UnSupport this Testcase:$Testcase.Please check it!"
    echo $cmdStr
    retCode=2
    exit $retCode
    ;;
esac

#--------------------------------------
popd
#--------------------------------------

echo [$TestCase] convert Ini file to csv file finished!
echo --------------------------------------------------------------------------------
exit $retCode
