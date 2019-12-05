#!/bin/bash

if [ $# -ne 1 ];then
 echo "usage: $0 TestType" 
 exit 1
fi
#------------------------------------------------------
TestType=$1
#------------------------------------------------------

#---------------------------------------------------------
srcCaseClassPath="ClassFiles_${TestType}"
Std_CaseFile=CaseRef_${TestType}.file
#---------------------------------------------------------
CaseClassFile=Test.py
destClassPath="${srcCaseClassPath}"
destClassFile="${destClassPath}/${CaseClassFile}"
#---------------------------------------------------------

start_time=`date +%s`              #定义脚本运行的开始时间


#开始制作测试用例类文件
mkdir $srcCaseClassPath -p
mkdir $destClassPath -p

rm -rf $srcCaseClassPath/*
rm -rf $destClassPath/*

#以下replace_str.sh 文件可以根据给定参数替换掉标准文件中的字段，
#从而生成所需的用例类文件，下列操作用来将当前目录下的文件拷贝到指定目录，
#之后在指定目录下开展具体操作
\cp replace_str.sh $srcCaseClassPath -f
\cp StdCode.txt $srcCaseClassPath -f
\cp ${Std_CaseFile} $srcCaseClassPath -f

#进入指定目录开始工作
cd $srcCaseClassPath

#循环遍历所有测试用例,逐一生成所需的用例类文件
i=1
for case_name_str in `cat ${Std_CaseFile} |awk -F":" '{print $1}'`
do
{
  #TestCaseName=$filename
  echo $case_name_str
  case_name=`echo $case_name_str | cut -d '[' -f 2  | cut -d ']' -f 1 `
  #echo "第[$i]个测试用例:${casename}:"
  testcase=$case_name
  testcase_spec=`cat ${Std_CaseFile} |grep "\[${case_name}\]" | awk -F":" '{print $2}'`
  #echo "==============================="
  echo "testcase:[$testcase]"
  echo "testcase_spec:[$testcase_spec]"
  #echo "==============================="
  sh replace_str.sh $testcase $testcase_spec

  let i++
}
done

#pwd
cd ../  #返回之前的目录
#pwd


#合并各个不同的测试用例类文件到一个大文件
#:> ${destClassFile}  #初始化情况文件

#加入python文件开头内容
cat StdHead.txt > ${destClassFile}

i=1
for case_name_str in `cat ${Std_CaseFile} |awk -F":" '{print $1}'`
do
{
  #echo "=================================="
  #echo "第[$i]个测试用例:$filename:"
  case_name=`echo $case_name_str | cut -d '[' -f 2  | cut -d ']' -f 1 `
  #echo "${srcCaseClassPath}/${case_name}_class.txt"
  if [ -s ${srcCaseClassPath}/${case_name}_class.txt ];
  then
    cat ${srcCaseClassPath}/${case_name}_class.txt >> ${destClassFile}
  else
    echo "Test Case class file:${srcCaseClassPath}/${case_name}_class.txt Not exists!"
  fi
  let i++
}
done

\cp "${destClassFile}" "TestSuite_${TestType}.py" -f

echo "*********************************************"
stop_time=`date +%s`  #定义脚本运行的结束时间

echo "**********************************************"
echo "Exec Time:`expr $stop_time - $start_time`s"
echo "**********************************************"

echo "Making the class files finished."
