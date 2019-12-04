#!/bin/bash

if [ $# -ne 6 ];then
 echo "usage: $0 TestType Platform TestCase TestCase_absdir TestCase_absfile Node_num" 
 exit 1
fi
#----------------------------------------------------------------------------------------
TestType="$1"
Platform="$2"
TestCase="$3"
TestCase_absdir="$4"  #输入参数为绝对路径的原因是:含有不确定的包含ip的目录，直接获取比较困难,需再确认
TestCase_absfile="$5"
Node_num="$6"
#----------------------------------------------------------------------------------------
resultsPath=$(cat result_path.txt)
#ResultIniFile=$srcResultFile
#echo srcFile:$ResultIniFile
PointsPath='Points_Files'
curPointsIniDir='ini_Points'
#----------------------------------------------------------------------------------------
echo --------------------------------------------------------------------------------
echo "获取测试结果跑分..."
echo "当前路径:"
pwd 
echo --------------------------------------------------------------------------------

#------------------------------------------------------------------------------------
echo --------------------------------------------------------------------------------
testcase_file=`ls $testcase_absdir`
#echo 测试用例:$TestCase 的测试结果文件为:[$testcase_file]
echo $testcase_file
#testcase_absfile=$testcase_absdir/$testcase_file
#echo 测试用例:$TestCase 的测试结果文件为:[$testcase_absfile]

echo --------------------------------------------------------------------------------
#------------------------------------------------------------------------------------

destPath="${resultsPath}/${TestType}/${Platform}/$PointsPath/$TestCase"
mkdir $destPath -p


#There are many branches for test cases in judgment.So use case mode...
case $TestCase in
"iozone")
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    echo 测试用例:$TestCase 的测试结果文件内容为:
    cat $TestCase_absfile |tail -n 5 |tee "$TestCase_absdir/Points_${TestCase}_${Node_num}.txt"
    ;;

"netperf")
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    ;;

"lmbench")
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    ;;

"stream")
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    ;;

"UnixBench")
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    ;;

"spec2000-1core")
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    echo 测试用例:$TestCase 的测试结果文件内容为:
    #cat $TestCase_absfile |tail -n 5 |tee "$TestCase_absdir/Points_${TestCase}_${Node_num}.txt"
    ;;

"spec2000-ncore")
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    ;;

"spec2006-1core")
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    ;;

"spec2006-ncore")
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    ;;

"SpecJvm2008")
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    ;;


*)
    cmdStr="Error:UnSupport this Testcase:$Testcase.Please check it!"
    echo $cmdStr
    ;;
esac


#echo 测试用例:$TestCase 的测试结果文件内容为:
#cat $TestCase_absfile |tail -n 5 |tee "$TestCase_absdir/Points_${TestCase}_${Node_num}.txt"
\cp "$TestCase_absdir/Points_${TestCase}_${Node_num}.txt" $destPath -f || echo copy failed!
testcase_pointsFile=$curPointsIniDir/$TestCase.ini
\cp $testcase_pointsFile $destPath/${TestCase}_${Node_num}.ini -f


echo --------------------------------------------------------------------------------
