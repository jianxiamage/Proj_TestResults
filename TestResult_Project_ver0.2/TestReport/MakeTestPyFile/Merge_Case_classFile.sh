#!/bin/bash

#---------------------------------------------------------
srcCaseClassPath=OS_CaseClassDir
TestListFile=TestCaseRelation.file
TestListFile="TestCaseList/TestCaseList_${TestType}.txt"
#---------------------------------------------------------
#destPath="${srcCaseClassPath}/${TestType}/${Platform}"
CaseClassAllFile=Test.py
destClassPath="${srcCaseClassPath}"
destClassFile="${destClassPath}/${CaseClassAllFile}"
#---------------------------------------------------------

#开始制作测试用例类文件
mkdir $srcCaseClassPath -p
mkdir $destClassPath -p

\cp replace_str.sh $srcCaseClassPath -f
\cp StdCode.txt $srcCaseClassPath -f
\cp TestCaseRelation.file $srcCaseClassPath -f

cd $srcCaseClassPath

i=1
for case_name_str in `cat TestCaseRelation.file |awk -F":" '{print $1}'`
do
  #TestCaseName=$filename
  echo $case_name_str
  case_name=`echo $case_name_str | cut -d '[' -f 2  | cut -d ']' -f 1 `
  echo "第[$i]个测试用例:${casename}:"
  testcase=$case_name
  testcase_spec=`cat TestCaseRelation.file |grep "\[${case_name}\]" | awk -F":" '{print $2}'`
  echo "==============================="
  echo "testcase:[$testcase]"
  echo "testcase_spec:[$testcase_spec]"
  echo "==============================="
  sh replace_str.sh $testcase $testcase_spec

  let i++
  
done

pwd
cd ../

#加入python文件开头内容
cat StdHead.txt > ${destClassFile}

#合并各个不同的测试用例类文件到一个大文件
#cat TestCaseRelation.file |awk -F":" '{print $2}'
#:> ${destClassFile}

i=1
#for filename in `cat ${TestListFile}`
for case_name_str in `cat TestCaseRelation.file |awk -F":" '{print $1}'`
do
  #TestCaseName=$filename
  echo "=================================="
  echo "第[$i]个测试用例:$filename:"
  case_name=`echo $case_name_str | cut -d '[' -f 2  | cut -d ']' -f 1 `
  echo "${srcCaseClassPath}/${case_name}_class.txt"
  if [ -s ${srcCaseClassPath}/${case_name}_class.txt ];
  then
    cat ${srcCaseClassPath}/${case_name}_class.txt >> ${destClassFile}
  else
    echo "Test Case class file:${srcCaseClassPath}/${case_name}_class.txt Not exists!"
  fi
  let i++
done

#success_count=$(cat ${okfile}|wc -l)
#echo "**********************************************"
#echo "The count of the test case class file is:${success_count}"
#echo "**********************************************"
echo "Merging the class files finished."
