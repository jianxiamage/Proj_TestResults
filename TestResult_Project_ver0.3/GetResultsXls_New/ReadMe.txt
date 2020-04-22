一、本模块的功能是读取以下几个测试的测试结果跑分情况:

1.文件系统性能（3.13）
  iozone

2.内存性能测试(3.15)
  stream

3.java性能测试(3.16)
  SpecJvm2008 

4.Unixbench测试(3.17)
  UnixBench

5.SPECcpu 2000测试(3.18)
  spec2000-1core
  spec2000-ncore

6.SPECcpu 2006测试(3.19)
  spec2006-1core
  spec2006-ncore


二、当前模块包含以几个字模块：

1.ResultFile_Grab  
  功能:将本地同步目录下的测试结果按照给定参数分类

2.Make_Point_Files
  功能:按照给定参数，分类将性能跑分结果文件按照ini文件格式存入各自目录

3.Make_Excel_Files
  功能:按照给定参数,分类生成不同测试用例的性能跑分结果

4.Excel_Merge_Proj
  功能:按照给定参数,分类合并各性能测试用例跑分结果

5.Excel_Summary_Proj
  功能:按照给定参数,分类合并各平台的性能测试用例跑分结果到一个大的Excel表格中

