#!/bin/bash

if [ $# -ne 5 ];then
 #echo "usage: $0 TestType Platform TestCase TestCase_absdir TestCase_absfile Node_num" 
 echo "usage: $0 TestType Platform TestCase TestCase_absdir Node_num" 
 exit 1
fi
#----------------------------------------------------------------------------------------
TestType="$1"
Platform="$2"
TestCase="$3"
TestCase_absdir="$4"  #输入参数为绝对路径的原因是:含有不确定的包含ip的目录，直接获取比较困难,需再确认
Node_num="$5"
#----------------------------------------------------------------------------------------
resultsPath=$(cat data_path.txt)
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

echo --------------------------------------------------------------------------------
echo ================TestCase_absdir:=================
echo $TestCase_absdir
echo --------------------------------------------------------------------------------
testcase_file=`ls $TestCase_absdir`
#echo 测试用例:$TestCase 的测试结果文件为:[$testcase_file]
echo $testcase_file
#testcase_absfile=$testcase_absdir/$testcase_file
#echo 测试用例:$TestCase 的测试结果文件为:[$testcase_absfile]

echo --------------------------------------------------------------------------------

destPath="${resultsPath}/${TestType}/${Platform}/$TestCase/$PointsPath"
mkdir $destPath -p


#There are many branches for test cases in judgment.So use case mode...
case $TestCase in
"iozone")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    testcase_file=`ls $TestCase_absdir`
    #echo 测试用例:$TestCase 的测试结果文件为:[$testcase_file]
    echo $testcase_file
    testcase_absfile=$TestCase_absdir/$testcase_file
    echo 测试用例:$TestCase 的测试结果文件为:
    echo [$testcase_absfile]
    echo --------------------------------------------------------------------------------
    echo 测试用例:$TestCase 的测试结果文件内容为:
    cat $testcase_absfile |tail -n 5 |tee "$TestCase_absdir/Points_${TestCase}_${Node_num}.txt"
    echo --------------------------------------------------------------------------------
    \cp "$TestCase_absdir/Points_${TestCase}_${Node_num}.txt" $destPath -f || echo copy failed!
    testcase_pointsFile=$curPointsIniDir/$TestCase.ini
    \cp $testcase_pointsFile $destPath/${TestCase}_${Node_num}.ini -f
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
    testcase_file=`ls $TestCase_absdir`
    #echo 测试用例:$TestCase 的测试结果文件为:[$testcase_file]
    echo $testcase_file
    testcase_absfile=$TestCase_absdir/$testcase_file
    echo 测试用例:$TestCase 的测试结果文件为:[$testcase_absfile]
    echo 测试用例:$TestCase 的测试结果文件内容为:
    #cat $testcase_absfile |tail -n 5 |tee "$TestCase_absdir/Points_${TestCase}_${Node_num}.txt"
    sed -n '/Processor/,$ p' $testcase_absfile | tee "$TestCase_absdir/Points_${TestCase}_${Node_num}.txt"
    echo --------------------------------------------------------------------------------
    \cp "$TestCase_absdir/Points_${TestCase}_${Node_num}.txt" $destPath -f || echo copy failed!
    testcase_pointsFile=$curPointsIniDir/$TestCase.ini
    \cp $testcase_pointsFile $destPath/${TestCase}_${Node_num}.ini -f
    echo --------------------------------------------------------------------------------
    ;;

"stream")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    testcase_file=`ls $TestCase_absdir`
    echo 测试用例:$TestCase 的测试结果文件为:[$testcase_file]
    echo 测试用例:$TestCase 的单核测试结果文件内容为:
    grep -A 5 "Function" $TestCase_absdir/stream1* | tee "$TestCase_absdir/Points_${TestCase}_1core_${Node_num}.txt"

    echo 测试用例:$TestCase 的多核测试结果文件内容为:
    grep -A 5 "Function" $TestCase_absdir/stream4* |tee "$TestCase_absdir/Points_${TestCase}_ncore_${Node_num}.txt"

    echo --------------------------------------------------------------------------------
    \cp "$TestCase_absdir/Points_${TestCase}_1core_${Node_num}.txt" $destPath -f || echo copy failed!
    \cp "$TestCase_absdir/Points_${TestCase}_ncore_${Node_num}.txt" $destPath -f || echo copy failed!

    testcase_pointsFile_1core="$curPointsIniDir/${TestCase}_1core.ini"
    \cp $testcase_pointsFile_1core $destPath/${TestCase}_1core_${Node_num}.ini -f

    testcase_pointsFile_ncore="$curPointsIniDir/${TestCase}_ncore.ini"
    \cp $testcase_pointsFile_ncore $destPath/${TestCase}_ncore_${Node_num}.ini -f
    #echo --------------------------------------------------------------------------------
    ;;

"UnixBench")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    testcase_file=`ls $TestCase_absdir`
    echo 测试用例:$TestCase 的测试结果文件为:[$testcase_file]
    echo 测试用例:$TestCase 的单核测试结果文件内容为:
    echo --------------------------------------------------------------------------------
    grep -A 15 "System Benchmarks Index Values" $TestCase_absdir/Unixbench_1_* | tee "$TestCase_absdir/Points_${TestCase}_1thread_${Node_num}.txt"

    echo 测试用例:$TestCase 的2核测试结果文件内容为:
    echo --------------------------------------------------------------------------------
    grep -A 15 "System Benchmarks Index Values" $TestCase_absdir/Unixbench_2_* | tee "$TestCase_absdir/Points_${TestCase}_2thread_${Node_num}.txt"

    echo 测试用例:$TestCase 的4核测试结果文件内容为:
    echo --------------------------------------------------------------------------------
    grep -A 15 "System Benchmarks Index Values" $TestCase_absdir/Unixbench_4_* | tee "$TestCase_absdir/Points_${TestCase}_4thread_${Node_num}.txt"

    echo 测试用例:$TestCase 的8核测试结果文件内容为:
    echo --------------------------------------------------------------------------------
    grep -A 15 "System Benchmarks Index Values" $TestCase_absdir/Unixbench_8_* | tee "$TestCase_absdir/Points_${TestCase}_8thread_${Node_num}.txt"

    echo 测试用例:$TestCase 的16核测试结果文件内容为:
    echo --------------------------------------------------------------------------------
    grep -A 15 "System Benchmarks Index Values" $TestCase_absdir/Unixbench_16_* | tee "$TestCase_absdir/Points_${TestCase}_16thread_${Node_num}.txt"


    #--------------------------------------------------------------------------------
    \cp "$TestCase_absdir/Points_${TestCase}_1thread_${Node_num}.txt" $destPath -f || echo copy failed!
    \cp "$TestCase_absdir/Points_${TestCase}_2thread_${Node_num}.txt" $destPath -f || echo copy failed!
    \cp "$TestCase_absdir/Points_${TestCase}_4thread_${Node_num}.txt" $destPath -f || echo copy failed!
    \cp "$TestCase_absdir/Points_${TestCase}_8thread_${Node_num}.txt" $destPath -f || echo copy failed!
    \cp "$TestCase_absdir/Points_${TestCase}_16thread_${Node_num}.txt" $destPath -f || echo copy failed!

    testcase_pointsFile_1thread="$curPointsIniDir/${TestCase}_1thread.ini"
    \cp $testcase_pointsFile_1thread $destPath/${TestCase}_1thread_${Node_num}.ini -f

    testcase_pointsFile_2thread="$curPointsIniDir/${TestCase}_2thread.ini"
    \cp $testcase_pointsFile_2thread $destPath/${TestCase}_2thread_${Node_num}.ini -f

    testcase_pointsFile_4thread="$curPointsIniDir/${TestCase}_4thread.ini"
    \cp $testcase_pointsFile_4thread $destPath/${TestCase}_4thread_${Node_num}.ini -f

    testcase_pointsFile_8thread="$curPointsIniDir/${TestCase}_8thread.ini"
    \cp $testcase_pointsFile_8thread $destPath/${TestCase}_8thread_${Node_num}.ini -f

    testcase_pointsFile_16thread="$curPointsIniDir/${TestCase}_16thread.ini"
    \cp $testcase_pointsFile_16thread $destPath/${TestCase}_16thread_${Node_num}.ini -f
    #echo --------------------------------------------------------------------------------
    ;;

"spec2000-1core")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    testcase_file=`ls $TestCase_absdir`
    echo 测试用例:$TestCase 的测试结果文件为:[$testcase_file]
    echo 测试用例:$TestCase 的测试结果文件内容为:
    grep -A 16 "=====" $TestCase_absdir/CFP2000.001.asc |tee "$TestCase_absdir/Points_${TestCase}_CFP_${Node_num}.txt"
    grep -A 14 "=====" $TestCase_absdir/CINT2000.001.asc |tee "$TestCase_absdir/Points_${TestCase}_CINT_${Node_num}.txt"

    echo --------------------------------------------------------------------------------
    \cp "$TestCase_absdir/Points_${TestCase}_CFP_${Node_num}.txt" $destPath -f || echo copy failed!
    \cp "$TestCase_absdir/Points_${TestCase}_CINT_${Node_num}.txt" $destPath -f || echo copy failed!

    testcase_pointsFile_CFP="$curPointsIniDir/${TestCase}_CFP.ini"
    \cp $testcase_pointsFile_CFP $destPath/${TestCase}_CFP_${Node_num}.ini -f

    testcase_pointsFile_CINT="$curPointsIniDir/${TestCase}_CINT.ini"
    \cp $testcase_pointsFile_CINT $destPath/${TestCase}_CINT_${Node_num}.ini -f
    echo --------------------------------------------------------------------------------
    ;;

"spec2000-ncore")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    testcase_file=`ls $TestCase_absdir`
    echo --------------------------------------------------------------------------------
    echo 测试用例:$TestCase 的测试结果文件为
    echo [$testcase_file]
    echo --------------------------------------------------------------------------------
    echo 测试用例:$TestCase 的测试结果文件内容为:
    grep -A 16 "=====" $TestCase_absdir/CFP2000.002.asc |tee "$TestCase_absdir/Points_${TestCase}_CFP_${Node_num}.txt"
    grep -A 14 "=====" $TestCase_absdir/CINT2000.002.asc |tee "$TestCase_absdir/Points_${TestCase}_CINT_${Node_num}.txt"

    \cp "$TestCase_absdir/Points_${TestCase}_CFP_${Node_num}.txt" $destPath -f || echo copy failed!
    \cp "$TestCase_absdir/Points_${TestCase}_CINT_${Node_num}.txt" $destPath -f || echo copy failed!

    testcase_pointsFile_CFP="$curPointsIniDir/${TestCase}_CFP.ini"
    \cp $testcase_pointsFile_CFP $destPath/${TestCase}_CFP_${Node_num}.ini -f

    testcase_pointsFile_CINT="$curPointsIniDir/${TestCase}_CINT.ini"
    \cp $testcase_pointsFile_CINT $destPath/${TestCase}_CINT_${Node_num}.ini -f
    echo --------------------------------------------------------------------------------

    ;;

"spec2006-1core")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    testcase_file=`ls $TestCase_absdir`
    echo 测试用例:$TestCase 的测试结果文件为:[$testcase_file]
    echo 测试用例:$TestCase 的测试结果文件内容为:
    grep -A 19 "=====" $TestCase_absdir/CFP2006.001.txt | tee "$TestCase_absdir/Points_${TestCase}_CFP_${Node_num}.txt"
    grep -A 14 "=====" $TestCase_absdir/CINT2006.001.txt | tee "$TestCase_absdir/Points_${TestCase}_CINT_${Node_num}.txt"

    echo --------------------------------------------------------------------------------
    \cp "$TestCase_absdir/Points_${TestCase}_CFP_${Node_num}.txt" $destPath -f || echo copy failed!
    \cp "$TestCase_absdir/Points_${TestCase}_CINT_${Node_num}.txt" $destPath -f || echo copy failed!

    testcase_pointsFile_CFP="$curPointsIniDir/${TestCase}_CFP.ini"
    \cp $testcase_pointsFile_CFP $destPath/${TestCase}_CFP_${Node_num}.ini -f

    testcase_pointsFile_CINT="$curPointsIniDir/${TestCase}_CINT.ini"
    \cp $testcase_pointsFile_CINT $destPath/${TestCase}_CINT_${Node_num}.ini -f
    echo --------------------------------------------------------------------------------
    ;;

"spec2006-ncore")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    testcase_file=`ls $TestCase_absdir`
    echo --------------------------------------------------------------------------------
    echo 测试用例:$TestCase 的测试结果文件为
    echo [$testcase_file]
    echo --------------------------------------------------------------------------------
    echo 测试用例:$TestCase 的测试结果[浮点型]文件内容为:
    grep -A 19 "=====" $TestCase_absdir/CFP2006.002.txt | tee "$TestCase_absdir/Points_${TestCase}_CFP_${Node_num}.txt"

    echo 测试用例:$TestCase 的测试结果[整型]文件内容为:
    grep -A 14 "=====" $TestCase_absdir/CINT2006.002.txt | tee "$TestCase_absdir/Points_${TestCase}_CINT_${Node_num}.txt"

    \cp "$TestCase_absdir/Points_${TestCase}_CFP_${Node_num}.txt" $destPath -f || echo copy failed!
    \cp "$TestCase_absdir/Points_${TestCase}_CINT_${Node_num}.txt" $destPath -f || echo copy failed!

    testcase_pointsFile_CFP="$curPointsIniDir/${TestCase}_CFP.ini"
    \cp $testcase_pointsFile_CFP $destPath/${TestCase}_CFP_${Node_num}.ini -f

    testcase_pointsFile_CINT="$curPointsIniDir/${TestCase}_CINT.ini"
    \cp $testcase_pointsFile_CINT $destPath/${TestCase}_CINT_${Node_num}.ini -f
    echo --------------------------------------------------------------------------------

    ;;

"SpecJvm2008")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    testcase_file=`ls $TestCase_absdir`
    #echo 测试用例:$TestCase 的测试结果文件为:[$testcase_file]
    echo $testcase_file
    testcase_absfile=$TestCase_absdir/$testcase_file
    echo 测试用例:$TestCase 的测试结果文件为:[$testcase_absfile]
    echo 测试用例:$TestCase 的测试结果文件内容为:
    grep -A 16 "Run is compliant" $TestCase_absdir/SPECjvm2008*.txt | tee "$TestCase_absdir/Points_${TestCase}_${Node_num}.txt"
    echo --------------------------------------------------------------------------------
    \cp "$TestCase_absdir/Points_${TestCase}_${Node_num}.txt" $destPath -f || echo copy failed!
    testcase_pointsFile=$curPointsIniDir/$TestCase.ini
    \cp $testcase_pointsFile $destPath/${TestCase}_${Node_num}.ini -f
    echo --------------------------------------------------------------------------------
    ;;

*)
    cmdStr="Error:UnSupport this Testcase:$Testcase.Please check it!"
    echo $cmdStr
    exit 1
    ;;
esac


#echo 测试用例:$TestCase 的测试结果文件内容为:
#cat $TestCase_absfile |tail -n 5 |tee "$TestCase_absdir/Points_${TestCase}_${Node_num}.txt"
#\cp "$TestCase_absdir/Points_${TestCase}_${Node_num}.txt" $destPath -f || echo copy failed!
#testcase_pointsFile=$curPointsIniDir/$TestCase.ini
#\cp $testcase_pointsFile $destPath/${TestCase}_${Node_num}.ini -f


echo --------------------------------------------------------------------------------
