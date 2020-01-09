本目录各个项目的简单介绍:
Common_Func  //公共方法库
Env_Init.sh  //初始化脚本，每次大的任务启动，需要手动清理环境
Result_Collection.sh //结果收集脚本,最核心脚本
RemoteNodeOSInfo.sh  //远程执行命令脚本，获取远程测试节点的系统信息,备用,已放置在目录:AlternativeFunc
Init_Env    //初始化小项目，对测试结果存放目录进行环境清理

Result_Collection.sh 脚本调用的项目(收集测试结果的所有小项目)

Get_OSInfo_Server  //从服务器端获取的测试节点系统信息
TestInfo           //获取测试信息
SetTestResult      //获取测试结果标记
TestReport         //生成测试报告
GetResultsXls      //生成性能跑分Excel文件
Backup_Tool        //备份测试结果到指定目录
Classify_Results   //重新将当前测试结果分类(最新要求为PC,Server,KVM)

CronTab_Proj       //定时任务,用于定时收集测试结果
Rsync_Tool         //同步任务,将服务器上的测试结果文件同步到本地服务器
Rsync_Log          //同步任务,将服务器上的每个测试用例的执行Log文件同步到本地服务器

备用脚本:
Extended_GetResultsXls
Get_OSInfo_Remote

收集log的一般步骤:
1.前提
  在此之前，需要确定所有要收集测试结果的平台都已经正确配置，
  这些配置包括，确认ip，确认jenkins相关配置，节点配置，
  服务器10.2.5.25旧的结果文件备份后清空autotest_result目录内的内容
  开启所有相关的jenkins任务之后，确认各任务无误稳定后，再开始进行结果收集
  注:当前结果收集和jenkins任务两者独立，为确保收集工作正常开展，可以不必着急收集
     例如，可以等待jenkins任务开启一小时之后再开启，避免jenkins任务有错误发生，
     因为，结果收集是循环定时任务，如jenkins任务出错要重新开启，那么结果收集将会做无效的任务触发工作
  

2.测试结果同步工作
  cd Rsync_Tool
  执行脚本:Add_cron_task.sh
  本任务调用脚本:rsync_testFiles.sh
  不断的将服务器10.2.5.25上的autotest_result目录同步到本地服务器的/AutoTest下
  第一次执行，可以首先手动执行一次：rsync_testFiles.sh,
  然后执行脚本:Add_cron_task.sh
  这样可以清楚看到执行流程并能够发现是否有错误发生
  另外，想删除本定时任务:执行脚本Remove_cron_task.sh

  本步骤执行完并确认无误之后，再开启以下的步骤

3.测试结果收集工作环境初始化
  执行脚本:Env_Init.sh
  本初始化任务可以初始化收集结果的环境，包括python虚拟环境，以及各个结果生成目录的初始化工作等
 
4.定时收集当前的测试用例执行log
  本功能，是直接获取当前远程机器上的测试用例执行log，
  为实现尽量实时查看当前测试情况，需要循环定时执行本功能
  方法步骤:
           cd Rsync_Log
           执行脚本: Add_cron_task.sh
                    举例:测试类型->OS,测试平台->2K
                    sh Add_cron_task.sh OS 2K
                    如果想删除:
                    sh Remove_cron_task.sh OS 2K

5.定时收集测试结果
  本功能，是获取测试结果的核心
  每隔一定时间，会执行一次结果收集脚本，
  操作步骤:
  cd CronTab_Proj
  执行脚本:Add_cron_task.sh
                    举例:测试类型->OS,测试平台->2K
                    sh Add_cron_task.sh OS 2K
                    如果想删除:
                    sh Remove_cron_task.sh OS 2K

附录:参数列表
           -------------------------------------------------------------
           测试类型:  
           Kernel  //内核测试
           OS      //操作系统测试
           KVM     //KVM测试(暂未支持)

           测试平台:
           以OS为例，

           2K                    //2K平台
           7A                    //7A独显平台
           7A_2way               //7A双路平台
           7A_Integrated         //7A集显平台
           780                   //780平台
           3A_4000               //3A 4000平台
           -------------------------------------------------------------

