本目录下的脚本功能：
1.用于创建新的分类，将测试结果存储在/Results目录下
  以PC,Server,KVM为分类方式
  根据输入的测试类型及测试平台备份测试结果

  例如:
  sh BackUp_History.sh Kernel 2K  //将测试类型：Kernel，测试平台：2K 的测试结果进行提取分类,存储到目录/Results下 

2.用于备份测试结果

根据输入的测试类型及测试平台备份测试结果
例如:
sh BackUp_History.sh Kernel 2K  //将测试类型：Kernel，测试平台：2K 的测试结果进行备份
备份目录:/data/Kernel/History_Bak/2K/3.10.0-2.fc21.loongson.2k.24.mips64el

说明：
目录OSInfo下的脚本功能：
获取指定测试类型和平台下的机器信息
包括系统类型，系统版本，内核版本号

获取的版本号用于创建同名目录区分不同版本的测试情况
