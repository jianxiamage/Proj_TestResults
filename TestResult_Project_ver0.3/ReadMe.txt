本目录各个项目的简单介绍:
Common_Func  //公共方法库
Env_Init.sh  //初始化脚本，每次大的任务启动，需要手动清理环境
Result_Collection.sh //结果收集脚本,最核心脚本
RemoteNodeOSInfo.sh  //远程执行命令脚本，获取远程测试节点的系统信息,备用
Init_Env    //初始化小项目，对测试结果存放目录进行环境清理

Result_Collection.sh 脚本调用的项目(收集测试结果的所有小项目)

Get_OSInfo_Server  //从服务器端获取的测试节点系统信息
TestInfo           //获取测试信息
SetTestResult      //获取测试结果标记
TestReport         //生成测试报告
GetResultsXls      //生成性能跑分Excel文件
Backup_Tool        //备份测试结果到指定目录
Classify_Results   //重新将当前测试结果分类(最新要求为PC,Server,KVM)

CronTab_Proj       //定时任务
Rsync_Tool         //同步任务,将服务器上的测试结果文件同步到本地服务器

备用脚本:
Extended_GetResultsXls
Get_OSInfo_Remote
