#!/bin/bash

if [ $# -ne 4 ];then
 echo "usage: $0 TestType Platform TestCase Node_num" 
 exit 1
fi
#----------------------------------------------------------------------------------------
TestType="$1"
Platform="$2"
TestCase="$3"
Node_num="$4"
#----------------------------------------------------------------------------------------
resultsPath=$(cat result_path.txt)
PointsPath='Points_Files'
curPointsIniDir='ini_Points'
#----------------------------------------------------------------------------------------
detailDir="Detail"
destResultPath="${resultsPath}/${TestType}/${Platform}/${detailDir}/${TestCase}/${PointsPath}"
mkdir $destResultPath -p

#初始化测试结果文件,防止没有生成测试结果时,造成制作Excel失败的情况
#单线程
pointsFile_1thread="$curPointsIniDir/${TestCase}_1thread_BASELINE.ini"
\cp $pointsFile_1thread $destResultPath/${TestCase}_1_BASELINE_${Node_num}.ini -f

pointsFile_1thread="$curPointsIniDir/${TestCase}_1thread_RESULT.ini"
\cp $pointsFile_1thread $destResultPath/${TestCase}_1_RESULT_${Node_num}.ini -f

pointsFile_1thread="$curPointsIniDir/${TestCase}_1thread_INDEX.ini"
\cp $pointsFile_1thread $destResultPath/${TestCase}_1_INDEX_${Node_num}.ini -f

#2线程
pointsFile_2thread="$curPointsIniDir/${TestCase}_2thread_BASELINE.ini"
\cp $pointsFile_2thread $destResultPath/${TestCase}_2_BASELINE_${Node_num}.ini -f

pointsFile_2thread="$curPointsIniDir/${TestCase}_2thread_RESULT.ini"
\cp $pointsFile_2thread $destResultPath/${TestCase}_2_RESULT_${Node_num}.ini -f

pointsFile_2thread="$curPointsIniDir/${TestCase}_2thread_INDEX.ini"
\cp $pointsFile_2thread $destResultPath/${TestCase}_2_INDEX_${Node_num}.ini -f

#4线程
pointsFile_4thread="$curPointsIniDir/${TestCase}_4thread_BASELINE.ini"
\cp $pointsFile_4thread $destResultPath/${TestCase}_4_BASELINE_${Node_num}.ini -f

pointsFile_4thread="$curPointsIniDir/${TestCase}_4thread_RESULT.ini"
\cp $pointsFile_4thread $destResultPath/${TestCase}_4_RESULT_${Node_num}.ini -f

pointsFile_4thread="$curPointsIniDir/${TestCase}_4thread_INDEX.ini"
\cp $pointsFile_4thread $destResultPath/${TestCase}_4_INDEX_${Node_num}.ini -f

#8线程
pointsFile_8thread="$curPointsIniDir/${TestCase}_8thread_BASELINE.ini"
\cp $pointsFile_8thread $destResultPath/${TestCase}_8_BASELINE_${Node_num}.ini -f

pointsFile_8thread="$curPointsIniDir/${TestCase}_8thread_RESULT.ini"
\cp $pointsFile_8thread $destResultPath/${TestCase}_8_RESULT_${Node_num}.ini -f

pointsFile_8thread="$curPointsIniDir/${TestCase}_8thread_INDEX.ini"
\cp $pointsFile_8thread $destResultPath/${TestCase}_8_INDEX_${Node_num}.ini -f

#16线程
pointsFile_16thread="$curPointsIniDir/${TestCase}_16thread_BASELINE.ini"
\cp $pointsFile_16thread $destResultPath/${TestCase}_16_BASELINE_${Node_num}.ini -f

pointsFile_16thread="$curPointsIniDir/${TestCase}_16thread_RESULT.ini"
\cp $pointsFile_16thread $destResultPath/${TestCase}_16_RESULT_${Node_num}.ini -f

pointsFile_16thread="$curPointsIniDir/${TestCase}_16thread_INDEX.ini"
\cp $pointsFile_16thread $destResultPath/${TestCase}_16_INDEX_${Node_num}.ini -f
