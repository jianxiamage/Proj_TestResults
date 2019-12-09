#!/bin/bash

if [ $# -ne 2 ];then
 echo "usage: $0 TestCase TestCase_Spec" 
 exit 1
fi

#--------------------------------------------------------
CaseName=$1                   #输入参数:测试用例标准名称
CaseName_Spec=$2              #输入参数：测试用例名称别名
#--------------------------------------------------------
stdStr=Demo                   #标准名称
stdStr_Spec=Demo              #标准名称的别名(case_name=?)
TestCase=$CaseName            #测试用例名称
TestCase_Spec=$CaseName_Spec  #测试用例名称(实际名称，可能含有特殊字符，如[-])
#--------------------------------------------
StdFile=StdCode.txt
TestCaseFile=${TestCase}_class.txt
#--------------------------------------------

#根据标准文件，生成各个测试用例对应的测试类文件
\cp  $StdFile $TestCaseFile -f

#---------------------------------------------------------------------------------
#替换类名
src_classLine="class ${stdStr}"
desc_classLine="class ${TestCase}"

sed -i "s@${src_classLine}@${desc_classLine}@g" $TestCaseFile

#---------------------------------------------------------------------------------
#替换测试用例别名
#(实际名称：由于命名不统一，名称中含有[-]，python语法中是不允许使用[-]命名的)
#例如：spec2000-1core,在python中只能命名为[spec2000_1core],而在其他的调用参数中使用的是:[spec2000-1core]

src_nameLine="case_name='${stdStr}'"
desc_nameLine="case_name='${TestCase_Spec}'"

#sed -n '/${src_nameLine}/p' $TestCaseFile > xxxx.txt  #有错误，单引号应该换成双引号
#sed -n "/${src_nameLine}/p" $TestCaseFile > xxxx.txt  #正确

sed -i "s@${src_nameLine}@${desc_nameLine}@g" $TestCaseFile

#---------------------------------------------------------------------------------
#替换函数名称
#def test_TestCase
src_funcLine="def test_${stdStr}"
desc_funcLine="def test_${TestCase}"

sed -i "s@${src_funcLine}@${desc_funcLine}@g" $TestCaseFile
