本目录下的脚本功能：
用于备份测试结果

根据输入的测试类型及测试平台备份测试结果
例如:
sh BackUp_History.sh Kernel 2K  //将测试类型：Kernel，测试平台：2K 的测试结果进行备份
备份目录:/data/Kernel/History_Bak/2K/3.10.0-2.fc21.loongson.2k.24.mips64el

说明：
目录OSInfo下的脚本功能：
通过执行远程命令，在目标节点上执行命令，
获取指定测试类型和平台下的机器信息
包括系统类型，系统版本，内核版本号

获取的版本号用于创建同名目录区分不同版本的测试情况


目录OSInfo_Server下的脚本功能(本目录已经移动至../Common_Func/):
修改历史:
1.区别于OSInfo的特点:不是在目标节点执行命令，
  而是直接在服务器上获取系统信息文件(提前在测试开启后的init环境过程中生成)
  通过执行远程命令，在目标节点上执行命令，
  获取指定测试类型和平台下的机器信息
  包括系统类型，系统版本，内核版本号
2.现在是获取服务器同步目录下的文件获取

获取的版本号用于创建同名目录区分不同版本的测试情况

为方便统一调用，将OSInfo_Server放在了../Init_Env/目录下
