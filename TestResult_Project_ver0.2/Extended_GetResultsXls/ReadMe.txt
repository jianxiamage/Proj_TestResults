一.本模块的功能是读取以下几个测试的测试结果:
-----------------------------------------------

1.文件系统性能（3.13）
  iozone

2.内存性能测试(3.15)
  stream

3.java性能测试(3.16)
  
4.Unixbench测试(3.17)

5.SPECcpu 2000测试(3.18)

6.SPECcpu 2006测试(3.19)

二.关于代码优化
-----------------------------------------------
代码中多处用到了目标路径:/data
但在测试时,可能希望这个目录换为其他目录方便测试,以免对/data原目录造成影响
因此,采用下面方法:
1.shell脚本中的改法
  可以定义一个文件result_path.txt,内容即为:/data(本例为此,可任意设置)
  其他变量定义的部分可以使用下列脚本进行修改
  replace.sh

2.python脚本中的改法
  不如shell脚本修改方便,目前,想到新编写shell脚本直接修改源码
  replace_py.sh
  
3.其他地方修改
  查询还有没修改的地方,可以使用下列脚本进行修改
  replace_data.sh
