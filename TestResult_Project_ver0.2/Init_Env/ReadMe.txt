
说明：
本目录下存放的是自动化测试的结果:

=============================================================
  用户重点关注的是两个方面：
  [1]测试结果(测试报告)
     打开report_simple.html进行查看
     将来如果测试用例较多时，可以打开report.html查看

  [2]性能跑分情况
     打开Results_Excel目录下的Excel文件进行查看
=============================================================

各目录文件简介：
1.测试结果（测试报告）
  以操作系统(OS)测试，7A双路为例，可以打开：
  OS/7A_2way/
  文件功能简介：
  
  ├── Detail            //性能跑分各测试用例中间产生文件
  ├── ip_list.ini       //本组ip列表
  ├── merge_Excel       //各个测试用例性能跑分的Excel文件
  ├── report.html       //测试结果(测试报告)企业版，功能较强大复杂
  ├── report_simple.html//测试结果(测试报告)精简版，功能简洁明了，推荐查看
  ├── Results_Excel     //最终性能跑分结果Excel文件
  └── TestResults.ini   //以ini文件格式存放的测试结果，默认为1,测试成功时设置为0


2.其他文件简介
  根目录：
  Kernel  //内核测试目录
  KVM     //KVM测试目录
  OS      //操作系统测试目录

  以OS为例，OS目录文件简介：
  
  2K                    //2K平台
  780                   //780平台
  7A                    //7A独显平台
  7A_2way               //7A双路平台
  3A_4000               //3A 4000平台
  7A_Integrated         //7A集显平台
  TestcaseGroup_OS.ini  //各测试用例的分组情况

