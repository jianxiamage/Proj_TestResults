#!/bin/bash
#set -e

if [ $# -ne 3 ];then
 echo "usage: $0 TestType Platform TestCase" 
 exit 1
fi
#----------------------------------------------------------------------------------------
TestType="$1"
Platform="$2"
TestCase="$3"
#----------------------------------------------------------------------------------------
resultsPath='/data'
#----------------------------------------------------------------------------------------



function check_result()
{
  ret_val=$1
  TestMode=$2
  if [ $? -eq 0 ];
  then
    echo "TestType:[${TestType}] Platform:[${Platform}] TestCase:[${TestMode}] setting result Excel file success!" >> $okfile
  else
    echo "TestType:[${TestType}] Platform:[${Platform}] TestCase:[${TestMode}] setting result Excel file failed!" >> $errfile
  fi
}

export WORKON_HOME=/home/work/env-wrapper

echo ---------------------------------
echo 'active the virtualenvwrapper'
echo ---------------------------------
source /usr/bin/virtualenvwrapper.sh

echo ---------------------------------
echo 'change to virtualenv:env-excel'
echo ---------------------------------
workon env-excel

#---------------------------------------------------
#进入测试用例目录
pushd ${TestCase}
#---------------------------------------------------

#----------------------------------------------------------------------------------------
Log_Dir='Log_MakeExcel'
okfile=../${Log_Dir}/ok_file.txt
errfile=../${Log_Dir}/err_file.txt
#----------------------------------------------------------------------------------------
mkdir ${Log_Dir} -p


echo "Begin to create test result by excel file..."

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
    sh create_Excel_Points_iozone.sh $TestType $Platform $TestCase
    check_result $? $TestCase
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
    sh create_Excel_Points_stream_1core.sh $TestType $Platform $TestCase
    check_result $? "stream_1core"

    #stream多核测试
    sh create_Excel_Points_stream_ncore.sh $TestType $Platform $TestCase
    check_result $? "stream_ncore"
    echo --------------------------------------------------------------------------------
    ;;

"UnixBench")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    
    #UnixBench在不同机器上执行不同的线程脚本，会生成不同的测试结果文件，因此需要判断后执行
    sh check_UnixBench_IniFile.sh $TestType $Platform
    check_result $? $TestCase
    #echo --------------------------------------------------------------------------------
    ;;

"spec2000-1core")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    
    #spec2000单核浮点测试
    sh create_Excel_Points_spec2000_1core_CFP.sh $TestType $Platform $TestCase
    check_result $? "spec2000_1core_CFP"

    #spec2000单核整型测试
    sh create_Excel_Points_spec2000_1core_CINT.sh $TestType $Platform $TestCase
    check_result $? "spec2000_1core_CINT"
    echo --------------------------------------------------------------------------------
    ;;

"spec2000-ncore")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr

    #spec2000多核浮点测试
    sh create_Excel_Points_spec2000_ncore_CFP.sh $TestType $Platform $TestCase
    check_result $? "spec2000_ncore_CFP"

    #spec2000多核整型测试
    sh create_Excel_Points_spec2000_ncore_CINT.sh $TestType $Platform $TestCase
    check_result $? "spec2000_ncore_CINT"

    echo --------------------------------------------------------------------------------
    ;;

"spec2006-1core")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr

    #spec2006单核浮点测试
    sh create_Excel_Points_spec2006_1core_CFP.sh $TestType $Platform $TestCase
    check_result $? "spec2006_1core_CFP"

    #spec2006单核整型测试
    sh create_Excel_Points_spec2006_1core_CINT.sh $TestType $Platform $TestCase
    check_result $? "spec2006_1core_CINT"

    echo --------------------------------------------------------------------------------
    ;;

"spec2006-ncore")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr

    #spec2006多核浮点测试
    sh create_Excel_Points_spec2006_ncore_CFP.sh $TestType $Platform $TestCase
    check_result $? "spec2006_ncore_CFP"

    #spec2006多核整型测试
    sh create_Excel_Points_spec2006_ncore_CINT.sh $TestType $Platform $TestCase
    check_result $? "spec2006_ncore_CINT"

    echo --------------------------------------------------------------------------------
    ;;

"SpecJvm2008")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr

    #SpecJvm2008测试
    sh create_Excel_Points_SpecJvm2008.sh $TestType $Platform $TestCase
    check_result $? $TestCase

    echo --------------------------------------------------------------------------------
    ;;

*)
    cmdStr="Error:UnSupport this Testcase:$Testcase.Please check it!"
    echo $cmdStr
    exit 1
    ;;
esac

#--------------------------------------
popd
#--------------------------------------

deactivate

echo [$TestCase] write results as Excel File successfully!
echo --------------------------------------------------------------------------------
