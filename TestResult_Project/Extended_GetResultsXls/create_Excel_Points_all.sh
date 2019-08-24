#!/bin/bash

if [ $# -ne 3 ];then
 echo "usage: $0 TestType Platform TestCase" 
 exit 1
fi
#----------------------------------------------------------------------------------------
TestType="$1"
Platform="$2"
TestCase="$3"
retCode=0
#----------------------------------------------------------------------------------------
resultsPath=$(cat data_path.txt)
#ResultIniFile=$srcResultFile
#echo srcFile:$ResultIniFile
PointsPath='Points_Files'
curPointsIniDir='ini_Points'
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
    sh create_Excel_Points_iozone.sh $TestType $Platform $TestCase || retCode=1
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

    retCode_1core=0   
    retCode_ncore=0   

    #stream单核测试
    sh create_Excel_Points_stream_1core.sh $TestType $Platform $TestCase  || retCode_1core=1

    #stream多核测试
    sh create_Excel_Points_stream_ncore.sh $TestType $Platform $TestCase  || retCode_ncore=1
    
    if [[ $retCode_1core -eq 0 ]] && [[ $retCode_ncore -eq 0 ]]
    then
      retCode=0
    else
      retCode=1
    fi
    echo --------------------------------------------------------------------------------
    ;;

"UnixBench")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr

    retCode_old=0
    retCode_new=0
    
    #UnixBench在不同机器上执行不同的线程脚本，会生成不同的测试结果文件，因此需要判断后执行
    sh check_UnixBench_IniFile.sh $TestType $Platform || retCode=1

    sh check_UnixBench_IniFile_new.sh $TestType $Platform || retCode=1

    if [[ $retCode_old -eq 0 ]] && [[ $retCode_new -eq 0 ]]
    then
      retCode=0
    else
      retCode=1
    fi

    echo --------------------------------------------------------------------------------
    ;;

"spec2000-1core")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    
    retCode_CFP=0
    retCode_CINT=0

    #spec2000单核浮点测试
    sh create_Excel_Points_spec2000_1core_CFP.sh $TestType $Platform $TestCase  || retCode_CFP=1

    #spec2000单核整型测试
    sh create_Excel_Points_spec2000_1core_CINT.sh $TestType $Platform $TestCase  || retCode_CINT=1

    if [[ $retCode_CFP -eq 0 ]] && [[ $retCode_CINT -eq 0 ]]
    then
      retCode=0
    else
      retCode=1
    fi

    echo --------------------------------------------------------------------------------
    ;;

"spec2000-ncore")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr

    retCode_CFP=0
    retCode_CINT=0

    #spec2000多核浮点测试
    sh create_Excel_Points_spec2000_ncore_CFP.sh $TestType $Platform $TestCase || retCode_CFP=1

    #spec2000多核整型测试
    sh create_Excel_Points_spec2000_ncore_CINT.sh $TestType $Platform $TestCase || retCode_CINT=1

    if [[ $retCode_CFP -eq 0 ]] && [[ $retCode_CINT -eq 0 ]]
    then
      retCode=0
    else
      retCode=1
    fi

    echo --------------------------------------------------------------------------------
    ;;

"spec2006-1core")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr

    retCode_CFP=0
    retCode_CINT=0

    #spec2006单核浮点测试
    sh create_Excel_Points_spec2006_1core_CFP.sh $TestType $Platform $TestCase || retCode_CFP=1

    #spec2006单核整型测试
    sh create_Excel_Points_spec2006_1core_CINT.sh $TestType $Platform $TestCase || retCode_CINT=1

    if [[ $retCode_CFP -eq 0 ]] && [[ $retCode_CINT -eq 0 ]]
    then
      retCode=0
    else
      retCode=1
    fi

    echo --------------------------------------------------------------------------------
    ;;

"spec2006-ncore")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr

    retCode_CFP=0
    retCode_CINT=0

    #spec2006多核浮点测试
    sh create_Excel_Points_spec2006_ncore_CFP.sh $TestType $Platform $TestCase || retCode_CFP=1

    #spec2006多核整型测试
    sh create_Excel_Points_spec2006_ncore_CINT.sh $TestType $Platform $TestCase || retCode_CINT=1

    if [[ $retCode_CFP -eq 0 ]] && [[ $retCode_CINT -eq 0 ]]
    then
      retCode=0
    else
      retCode=1
    fi

    echo --------------------------------------------------------------------------------
    ;;

"SpecJvm2008")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr

    #SpecJvm2008测试
    sh create_Excel_Points_SpecJvm2008.sh $TestType $Platform $TestCase || retCode=0

    echo --------------------------------------------------------------------------------
    ;;

*)
    cmdStr="Error:UnSupport this Testcase:$Testcase.Please check it!"
    echo $cmdStr
    exit 1
    ;;
esac

if [ $retCode -eq 0 ]
then
  echo "**************************************************************"
  echo [$TestCase] write results as Excel File successfully!
  echo "**************************************************************"
else
  echo "**************************************************************"
  echo Maybe the Test:[$TestCase] is running,Please wait...
  echo "**************************************************************"
fi

exit $retCode
