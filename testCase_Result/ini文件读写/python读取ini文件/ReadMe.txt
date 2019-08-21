一、程序初始化:

init_IPListFile.sh             //设置ip列表文件到不同类型及平台目录下
init_ShowResults.sh            //待用
init_TestEnv.sh                //总的初始化程序
init_TestGroupFile.sh          //将测试用例所属组文件设置到不同目录下
init_TestResultsFile_All.sh    //将测试结果写入到不同目录下
init_TestResultsFile_para.sh   //单一平台测试结果写入相应目录下

1.首先将ip列表文件拷贝到各个不同测试类型及测试平台的目录下
  在IP_List目录下存放着所有不同测试类型及测试平台的ip列表文件
  将各个不同ip列表文件拷贝到不同的测试类型及测试平台目录下
  例如，将ip_list_OS_7A.ini拷贝到/IP_List/OS/7A/ip_list.ini

  这里的目录/IP_List也可以是/data，当前尚未整合，尚需考虑
  执行脚本:sh init_IPListFile.sh

2.将测试用例分组情况文件拷贝到不同测试类型目录下
  例如：
  拷贝当前目录下文件:TestcaseGroup_OS.ini 到目录/data/OS/下
  执行脚本：sh init_TestGroupFile.sh

3.拷贝测试结果文件到不同测试类型和不同测试平台的目录下
  例如：
  拷贝当前目录下文件:TestResultFilePath.ini 到目录/data/OS/7A下
  执行脚本：
  sh init_TestResultsFile_para.sh OS  //拷贝操作系统测试结果文件

  拷贝三种类型测试结果文件
  sh init_TestResultsFile_All.sh

二、写入测试结果到配置文件

1.将当前测试结果写入各自测试结果文件

  例如：
  sh Set_ResultFile_OS_7A.sh  //测试类型：操作系统，测试平台：7A
  本脚本执行后，可以将操作系统测试，7A平台下的所有测试用例的结果写入相应的测试结果文件
  说明的是：初始化时，测试结果文件的结果值：1(暂定)，一旦测试成功，就会将其值设为:0
