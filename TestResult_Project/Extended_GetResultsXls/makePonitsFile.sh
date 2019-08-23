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
resultsPath='/data-std'
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
    testcase_file=`ls $TestCase_absdir | grep .ini`

    if [ -n "$testcase_file" ];
    then
        #echo 测试用例:$TestCase 的测试结果文件为:[$testcase_file]
        echo $testcase_file
        testcase_absfile=$TestCase_absdir/$testcase_file
        echo 测试用例:$TestCase 的测试结果文件为:
        echo [$testcase_absfile]
        echo --------------------------------------------------------------------------------
        echo 测试用例:$TestCase 的测试结果文件内容为:
        cat $testcase_absfile
        echo --------------------------------------------------------------------------------
        \cp ${testcase_absfile}  $destPath/${TestCase}_${Node_num}.ini -f || echo copy failed!
    else
        echo "当前测试:[$TestType] [$Platform] [${TestCase}],Node:[$Node_num],测试结果文件未生成,可能测试尚在进行中或失败,请继续等待..."
        #为防止读取ini文件出错,当未生成测试结果文件时,将默认的初始化ini文件拷贝到目标目录
        testcase_pointsFile=$curPointsIniDir/$TestCase.ini
        \cp $testcase_pointsFile $destPath/${TestCase}_${Node_num}.ini -f
        echo --------------------------------------------------------------------------------
    fi

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

    if [ -n "$testcase_file" ];
    then
        #echo 测试用例:$TestCase 的测试结果文件为:[$testcase_file]
        echo $testcase_file
        testcase_absfile=$TestCase_absdir/$testcase_file
        echo 测试用例:$TestCase 的测试结果文件为:[$testcase_absfile]
        echo 测试用例:$TestCase 的测试结果文件内容为:
        #cat $testcase_absfile |tail -n 5 |tee "$TestCase_absdir/Points_${TestCase}_${Node_num}.txt"
        sed -n '/Processor/,$ p' $testcase_absfile | tee "$TestCase_absdir/Points_${TestCase}_${Node_num}.txt"
        echo --------------------------------------------------------------------------------
       \cp "$TestCase_absdir/Points_${TestCase}_${Node_num}.txt" $destPath -f || echo copy failed!    
    else
        echo "当前测试:[$TestType] [$Platform] [${TestCase}],Node:[$Node_num]测试结果文件未生成,可能测试尚在进行中或失败,请继续等待..."
    fi

    testcase_pointsFile=$curPointsIniDir/$TestCase.ini
    \cp $testcase_pointsFile $destPath/${TestCase}_${Node_num}.ini -f
    echo --------------------------------------------------------------------------------
    ;;

"stream")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    testcase_file=`ls $TestCase_absdir |grep .ini`

    if [ -n "$testcase_file" ];
    then
        echo 测试用例:$TestCase 的测试结果文件为:[$testcase_file]
        echo 测试用例:$TestCase 的单核测试结果文件内容为:
        cat ${TestCase_absdir}/stream1*.ini

        echo 测试用例:$TestCase 的多核测试结果文件内容为:
        cat ${TestCase_absdir}/stream4*.ini

        #当生成测试结果文件时,将生成的ini文件拷贝到目标目录
        echo --------------------------------------------------------------------------------
        \cp ${TestCase_absdir}/stream1*.ini  $destPath/${TestCase}_1core_${Node_num}.ini -f || echo copy failed!
        \cp ${TestCase_absdir}/stream4*.ini  $destPath/${TestCase}_ncore_${Node_num}.ini -f || echo copy failed!
        echo --------------------------------------------------------------------------------
    
    else
        echo "当前测试:[$TestType] [$Platform] [${TestCase}],Node:[$Node_num],测试结果文件未生成,可能测试尚在进行中或失败,请继续等待..."

        #为防止读取ini文件出错,当未生成测试结果文件时,将默认的初始化ini文件拷贝到目标目录
        testcase_pointsFile_1core="$curPointsIniDir/${TestCase}_1core.ini"
        \cp $testcase_pointsFile_1core $destPath/${TestCase}_1core_${Node_num}.ini -f

        testcase_pointsFile_ncore="$curPointsIniDir/${TestCase}_ncore.ini"
        \cp $testcase_pointsFile_ncore $destPath/${TestCase}_ncore_${Node_num}.ini -f
    fi

    #echo --------------------------------------------------------------------------------
    ;;

"UnixBench")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    testcase_file=`ls $TestCase_absdir|grep .ini`

    if [ -n "$testcase_file" ];
    then
        echo 测试用例:$TestCase 的测试结果文件为:[$testcase_file]
        ls $TestCase_absdir  | grep "Unixbench_1_"
        if [ $? -eq 0 ];
        then
          echo 测试用例:$TestCase 的单线程测试结果文件内容为:
          echo --------------------------------------------------------------------------------
          cat ${TestCase_absdir}/Unixbench_1_*.ini
          \cp ${TestCase_absdir}/Unixbench_1_*.ini $destPath/${TestCase}_1thread_${Node_num}.ini -f

          #testcase_pointsFile_1thread="$curPointsIniDir/${TestCase}_1thread.ini"
          #\cp $testcase_pointsFile_1thread $destPath/${TestCase}_1thread_${Node_num}.ini -f
        fi

        ls $TestCase_absdir | grep "Unixbench_2_"
        if [ $? -eq 0 ];
        then
          echo 测试用例:$TestCase 的2线程测试结果文件内容为:
          echo --------------------------------------------------------------------------------
          cat ${TestCase_absdir}/Unixbench_2_*.ini
          \cp ${TestCase_absdir}/Unixbench_2_*.ini $destPath/${TestCase}_2thread_${Node_num}.ini -f

          #testcase_pointsFile_2thread="$curPointsIniDir/${TestCase}_2thread.ini"
          #\cp $testcase_pointsFile_2thread $destPath/${TestCase}_2thread_${Node_num}.ini -f
        fi

        ls $TestCase_absdir | grep "Unixbench_4_"
        if [ $? -eq 0 ];
        then
          echo 测试用例:$TestCase 的4线程测试结果文件内容为:
          echo --------------------------------------------------------------------------------
          cat ${TestCase_absdir}/Unixbench_4_*.ini
          \cp ${TestCase_absdir}/Unixbench_4_*.ini $destPath/${TestCase}_4thread_${Node_num}.ini -f

          #testcase_pointsFile_4thread="$curPointsIniDir/${TestCase}_4thread.ini"
          #\cp $testcase_pointsFile_4thread $destPath/${TestCase}_4thread_${Node_num}.ini -f
        fi

        ls $TestCase_absdir | grep "Unixbench_8_"
        if [ $? -eq 0 ];
        then
          echo 测试用例:$TestCase 的8线程测试结果文件内容为:
          echo --------------------------------------------------------------------------------
          cat ${TestCase_absdir}/Unixbench_8_*.ini
          \cp ${TestCase_absdir}/Unixbench_8_*.ini $destPath/${TestCase}_8thread_${Node_num}.ini -f

          #testcase_pointsFile_8thread="$curPointsIniDir/${TestCase}_8thread.ini"
          #\cp $testcase_pointsFile_8thread $destPath/${TestCase}_8thread_${Node_num}.ini -f
        fi

        ls $TestCase_absdir | grep "Unixbench_16_"
        if [ $? -eq 0 ];
        then
          echo 测试用例:$TestCase 的16线程测试结果文件内容为:
          echo --------------------------------------------------------------------------------
          cat ${TestCase_absdir}/Unixbench_16_*.ini
          \cp ${TestCase_absdir}/Unixbench_16_*.ini $destPath/${TestCase}_16thread_${Node_num}.ini -f

          #testcase_pointsFile_16thread="$curPointsIniDir/${TestCase}_16thread.ini"
          #\cp $testcase_pointsFile_16thread $destPath/${TestCase}_16thread_${Node_num}.ini -f
        fi

    else
        echo "当前测试:[$TestType] [$Platform] [${TestCase}],Node:[$Node_num]测试结果文件未生成,可能测试尚在进行中或失败,请继续等待..."
    fi

    #echo --------------------------------------------------------------------------------
    ;;

"spec2000-1core")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    testcase_file=`ls $TestCase_absdir | grep .ini`

    if [ -n "$testcase_file" ];
    then
        echo 测试用例:$TestCase 的测试结果文件为:[$testcase_file]

        echo 测试用例:$TestCase 的浮点型测试结果文件内容为:
        cat ${TestCase_absdir}/CFP*.ini

        echo 测试用例:$TestCase 的整型测试结果文件内容为:
        cat ${TestCase_absdir}/CINT*.ini

        echo --------------------------------------------------------------------------------
        \cp ${TestCase_absdir}/CFP*.ini $destPath/${TestCase}_CFP_${Node_num}.ini -f || echo copy failed!
        \cp ${TestCase_absdir}/CINT*.ini $destPath/${TestCase}_CINT_${Node_num}.ini -f || echo copy failed!

    else 
        echo "当前测试:[$TestType] [$Platform] [${TestCase}],Node:[$Node_num],测试结果文件未生成,可能测试尚在进行中或失败,请继续等待..."
        testcase_pointsFile_CFP="$curPointsIniDir/${TestCase}_CFP.ini"
        \cp $testcase_pointsFile_CFP $destPath/${TestCase}_CFP_${Node_num}.ini -f

        testcase_pointsFile_CINT="$curPointsIniDir/${TestCase}_CINT.ini"
        \cp $testcase_pointsFile_CINT $destPath/${TestCase}_CINT_${Node_num}.ini -f
        echo --------------------------------------------------------------------------------
    fi

    ;;

"spec2000-ncore")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    testcase_file=`ls $TestCase_absdir |grep .ini`

    if [ -n "$testcase_file" ];
    then
        echo 测试用例:$TestCase 的测试结果文件为:[$testcase_file]

        echo 测试用例:$TestCase 的浮点型测试结果文件内容为:
        cat ${TestCase_absdir}/CFP*.ini

        echo 测试用例:$TestCase 的整型测试结果文件内容为:
        cat ${TestCase_absdir}/CINT*.ini

        echo --------------------------------------------------------------------------------
        \cp ${TestCase_absdir}/CFP*.ini $destPath/${TestCase}_CFP_${Node_num}.ini -f || echo copy failed!
        \cp ${TestCase_absdir}/CINT*.ini $destPath/${TestCase}_CINT_${Node_num}.ini -f || echo copy failed!

    else
        echo "当前测试:[$TestType] [$Platform] [${TestCase}],Node:[$Node_num],测试结果文件未生成,可能测试尚在进行中或失败,请继续等待..."
        testcase_pointsFile_CFP="$curPointsIniDir/${TestCase}_CFP.ini"
        \cp $testcase_pointsFile_CFP $destPath/${TestCase}_CFP_${Node_num}.ini -f

        testcase_pointsFile_CINT="$curPointsIniDir/${TestCase}_CINT.ini"
        \cp $testcase_pointsFile_CINT $destPath/${TestCase}_CINT_${Node_num}.ini -f
        echo --------------------------------------------------------------------------------
    fi


    ;;

"spec2006-1core")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    testcase_file=`ls $TestCase_absdir |grep .ini`

    if [ -n "$testcase_file" ];
    then
        echo 测试用例:$TestCase 的测试结果文件为:[$testcase_file]

        echo 测试用例:$TestCase 的浮点型测试结果文件内容为:
        cat ${TestCase_absdir}/CFP*.ini

        echo 测试用例:$TestCase 的整型测试结果文件内容为:
        cat ${TestCase_absdir}/CINT*.ini

        echo --------------------------------------------------------------------------------
        \cp ${TestCase_absdir}/CFP*.ini $destPath/${TestCase}_CFP_${Node_num}.ini -f || echo copy failed!
        \cp ${TestCase_absdir}/CINT*.ini $destPath/${TestCase}_CINT_${Node_num}.ini -f || echo copy failed!

    else
        echo "当前测试:[$TestType] [$Platform] [${TestCase}],Node:[$Node_num],测试结果文件未生成,可能测试尚在进行中或失败,请继续等待..."
        testcase_pointsFile_CFP="$curPointsIniDir/${TestCase}_CFP.ini"
        \cp $testcase_pointsFile_CFP $destPath/${TestCase}_CFP_${Node_num}.ini -f

        testcase_pointsFile_CINT="$curPointsIniDir/${TestCase}_CINT.ini"
        \cp $testcase_pointsFile_CINT $destPath/${TestCase}_CINT_${Node_num}.ini -f
        echo --------------------------------------------------------------------------------
    fi

    ;;

"spec2006-ncore")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    testcase_file=`ls $TestCase_absdir |grep .ini`

    if [ -n "$testcase_file" ];
    then
        echo 测试用例:$TestCase 的测试结果文件为:[$testcase_file]

        echo 测试用例:$TestCase 的浮点型测试结果文件内容为:
        cat ${TestCase_absdir}/CFP*.ini

        echo 测试用例:$TestCase 的整型测试结果文件内容为:
        cat ${TestCase_absdir}/CINT*.ini

        echo --------------------------------------------------------------------------------
        \cp ${TestCase_absdir}/CFP*.ini $destPath/${TestCase}_CFP_${Node_num}.ini -f || echo copy failed!
        \cp ${TestCase_absdir}/CINT*.ini $destPath/${TestCase}_CINT_${Node_num}.ini -f || echo copy failed!

    else
        echo "当前测试:[$TestType] [$Platform] [${TestCase}],Node:[$Node_num],测试结果文件未生成,可能测试尚在进行中或失败,请继续等待..."
        testcase_pointsFile_CFP="$curPointsIniDir/${TestCase}_CFP.ini"
        \cp $testcase_pointsFile_CFP $destPath/${TestCase}_CFP_${Node_num}.ini -f

        testcase_pointsFile_CINT="$curPointsIniDir/${TestCase}_CINT.ini"
        \cp $testcase_pointsFile_CINT $destPath/${TestCase}_CINT_${Node_num}.ini -f
        echo --------------------------------------------------------------------------------
    fi

    ;;

"SpecJvm2008")
    echo --------------------------------------------------------------------------------
    cmdStr="The current test case is $TestCase."
    echo $cmdStr
    testcase_file=`ls $TestCase_absdir |grep .ini`

    #grep -A 16 "Run is compliant" $TestCase_absdir/SPECjvm2008*.txt | tee "$TestCase_absdir/Points_${TestCase}_${Node_num}.txt"
    if [ -n "$testcase_file" ];
    then
        #echo 测试用例:$TestCase 的测试结果文件为:[$testcase_file]
        echo $testcase_file
        testcase_absfile=$TestCase_absdir/$testcase_file
        echo 测试用例:$TestCase 的测试结果文件为:
        echo [$testcase_absfile]
        echo --------------------------------------------------------------------------------
        echo 测试用例:$TestCase 的测试结果文件内容为:
        cat $testcase_absfile
        echo --------------------------------------------------------------------------------
        \cp ${testcase_absfile}  $destPath/${TestCase}_${Node_num}.ini -f || echo copy failed!
    else
        echo "当前测试:[$TestType] [$Platform] [${TestCase}],Node:[$Node_num],测试结果文件未生成,可能测试尚在进行中或失败,请继续等待..."
        #为防止读取ini文件出错,当未生成测试结果文件时,将默认的初始化ini文件拷贝到目标目录
        testcase_pointsFile=$curPointsIniDir/$TestCase.ini
        \cp $testcase_pointsFile $destPath/${TestCase}_${Node_num}.ini -f
        echo --------------------------------------------------------------------------------
    fi

    ;;
esac

echo --------------------------------------------------------------------------------
