#!/bin/bash
#set -e
#----------------------------------------------------------------------------------------
#TestType="OS"
#Platform="2K"
#----------------------------------------------------------------------------------------
ResultPath='/data'
ReportFile="report.html"
ReportFile_Simple="report_simple.html"
#----------------------------------------------------------------------------------------
cur_path=$(cd `dirname $0`; pwd)
#project_name="${project_path##*/}"
echo "The current path is:"
echo $cur_path

Proj_Path="${cur_path}/TestResult_Project"
Proj_Name="TestReport"

TestType=("OS" "Kernel" "KVM")

Platform=("7A" "7A_Integrated" "7A_2way" "780" "2K")

i=1
j=1

for item_type in ${TestType[@]}; do

  echo "****************************************"
  echo "第$i次循环,测试类型:${item_type}"
  echo "****************************************"
  j=1
  for item_plat in ${Platform[@]}; do

    #echo 当前平台:$item_plat
      echo "第$j次循环，测试平台:$item_plat"

      pro_dir="${Proj_Path}/${Proj_Name}/${Proj_Name}_${TestType}_${Platform}"
      echo $pro_dir
      
      #删除精简版功能版测试报告
      echo "Delete the test report:${pro_dir}/$ReportFile"
      rm -rf ${pro_dir}/$ReportFile
      
      echo "----------------------------------------------"
      #删除精简版功能版测试报告
      echo "Delete the test report:${pro_dir}/${ReportFile_Simple}"
      rm -rf ${pro_dir}/$ReportFile_Simple
      let j++
  done
  
  let i++

done

echo "递归删除所有pyc文件"
find . -name "*.pyc"  | xargs rm -f

echo "递归删除所有html文件"
find . -name "*.html"  | xargs rm -f
echo ----------------------------------------------------

#pro_dir="${Proj_Path}/${Proj_Name}/${Proj_Name}_${TestType}_${Platform}"
#echo $pro_dir
##pushd $cur_path
#
#cd $pro_dir
#
##popd
#
#
#echo "----------------------------------------------"
##删除精简版功能版测试报告
#echo "Delete the test report:$ReportFile:"
#rm -rf $ReportFile 
#echo "----------------------------------------------"
#
#echo "----------------------------------------------"
##删除精简版功能版测试报告
#echo "Delete the test report:$ReportFile:"
#rm -rf $ReportFile_Simple 
#echo "----------------------------------------------"
