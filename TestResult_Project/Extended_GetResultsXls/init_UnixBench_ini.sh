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
resultsPath=$(cat data_path.txt)
PointsPath='Points_Files'
curPointsIniDir='ini_Points'
#----------------------------------------------------------------------------------------
detailDir="Detail"
destResultPath="${resultsPath}/${TestType}/${Platform}/${detailDir}/${TestCase}/${PointsPath}"
mkdir $destResultPath -p

#初始化测试结果文件,防止没有生成测试结果时,造成制作Excel失败的情况
#单线程
pointsFile_1thread="$curPointsIniDir/${TestCase}_1thread.ini"
\cp $pointsFile_1thread $destResultPath/${TestCase}_1thread_${Node_num}.ini -f


#2线程
pointsFile_2thread="$curPointsIniDir/${TestCase}_2thread.ini"
\cp $pointsFile_2thread $destResultPath/${TestCase}_2thread_${Node_num}.ini -f

#4线程
pointsFile_4thread="$curPointsIniDir/${TestCase}_4thread.ini"
\cp $pointsFile_4thread $destResultPath/${TestCase}_4thread_${Node_num}.ini -f

#8线程
pointsFile_8thread="$curPointsIniDir/${TestCase}_8thread.ini"
\cp $pointsFile_8thread $destResultPath/${TestCase}_8thread_${Node_num}.ini -f

#16线程
pointsFile_16thread="$curPointsIniDir/${TestCase}_16thread.ini"
\cp $pointsFile_16thread $destResultPath/${TestCase}_16thread_${Node_num}.ini -f
