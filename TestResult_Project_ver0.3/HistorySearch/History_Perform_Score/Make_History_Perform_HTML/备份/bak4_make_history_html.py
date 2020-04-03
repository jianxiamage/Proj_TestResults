#!/usr/bin/env python
# -*- coding=utf-8 -*-
import  sys
import  time,os
import webbrowser
import ConfigParser
import traceback
from collections import OrderedDict

#------------------------------------------
web_Path='/Results/'
searchDir='Search'
#------------------------------------------
if sys.getdefaultencoding() != 'utf-8':
    reload(sys)
    sys.setdefaultencoding('utf-8')
#------------------------------------------

#------------------------------------------
def get_fileName(input_dir,inputName):
  try:
    retCode = 1
    retStr = "Unknown"
    for root, dirs, files in os.walk(input_dir):
        #print("root", root)  # 当前目录路径
        #print("dirs", dirs)  # 当前路径下所有子目录
        print("files", files)  # 当前路径下所有非目录子文件
    for f in files:
        if f.startswith(input_name):
           print ("file name:" + f)
           retStr = f
           retCode = 0
        else:
           print ("file name:" + f)
  except Exception as E:
        print('str(e):', str(E))
  return retCode,retStr

#------------------------------------------

#防止自动将ini文件中的键名转换成小写
class myconf(ConfigParser.ConfigParser):
    def __init__(self,defaults=None):
        ConfigParser.ConfigParser.__init__(self,defaults=None)
    def optionxform(self, optionstr):
        return optionstr

def read_iniFile(inputFile,dicts={}):
    config = myconf()
    config.readfp(open(inputFile))

    section = 'History'
    j = 0
    for option in config.options(section):
        dicts[option] = config.get(section, option)
        value = dicts[option]
        print 'section:%s,option:%s,value:%s' %(section,option,value)
        #print(value)
        j = j + 1
 

class Template_mixin(object):
    """html报告"""
    HTML_TMPL = r"""
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <title>自动化测试报告</title>
            <link href="http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet">
            <h2 style="font-family: Microsoft YaHei">测试结果历史记录</h2>
            <style type="text/css" media="screen">
        body  { font-family: Microsoft YaHei,Tahoma,arial,helvetica,sans-serif;padding: 20px;}
        </style>
        </head>
        <body>
            <p class='attribute'><strong>测试详情 : </strong> 性能测试跑分历史版本执行结果对比</p>

            %(table_iozone)s
            %(table_stream)s
            %(table_2)s

            <table id='result_table' class="table table-condensed table-bordered table-hover">
                <colgroup>
                    <col align='left' />
                    <col align='right' />
                    <col align='right' />
                    <col align='right' />
                </colgroup>
                <tr id='header_row' class="text-center success" style="font-weight: bold;font-size: 14px;">
                    <th>用例名称/分类</th>
                    <th>历史对比查看</th>

                </tr>
                %(table_tr_UnixBench)s
            </table>


            %(table_SpecJvm2008)s

        </body>
        </html>"""
    #总数据
    TABLE_TMPL_TOTAL_1 = """
        <tr class='failClass warning'>
            <td>%(case_name)s</td>
            <td><a href="%(href_path)s" target="_blank">查看</a></td>
        </tr>"""
 
    #含有一个表行字段的用例
    TABLE_TMPL_TOTAL_ONE = """
    <table id='result_table' class="table table-condensed table-bordered table-hover">
        <colgroup>
            <col align='left' />
            <col align='right' />
            <col align='right' />
            <col align='right' />
        </colgroup>
        <tr id='header_row' class="text-center success" style="font-weight: bold;font-size: 14px;">
            <th>用例名称/分类</th>
            <th>历史对比查看</th>

        </tr>

        <tr class='failClass warning'>
            <td>%(case_name)s</td>
            <td><a href="%(href_path)s" target="_blank">查看</a></td>
        </tr>

   </table>"""


    #含有两个表行字段的用例
    TABLE_TMPL_TOTAL_TWO = """
    <table id='result_table' class="table table-condensed table-bordered table-hover">
        <colgroup>
            <col align='left' />
            <col align='right' />
            <col align='right' />
            <col align='right' />
        </colgroup>
        <tr id='header_row' class="text-center success" style="font-weight: bold;font-size: 14px;">
            <th>用例名称/分类</th>
            <th>历史对比查看</th>

        </tr>

        <tr class='failClass warning'>
            <td>%(case_name_1)s</td>
            <td><a href="%(href_path_1)s" target="_blank">查看</a></td>
        </tr>

        <tr class='failClass warning'>
            <td>%(case_name_2)s</td>
            <td><a href="%(href_path_2)s" target="_blank">查看</a></td>
        </tr>

   </table>"""



if __name__ == '__main__':

  try:

      #-------------------------------------------------------------------------------
      #输入参数
      #-------------------------------------------------------------------------------
      test_type = sys.argv[1]
      test_platform = sys.argv[2]
      class_type = sys.argv[3]
      test_case = sys.argv[4]
      node_num = sys.argv[5]
      #-------------------------------------------------------------------------------
      #定位历史log目录:
      #input_path=r"/Results/Server/History_Bak/7A_2way/OS/20192001-RC1.mips64/Detail/LogInfo/iozone"
      backup_path = 'History_Bak'
      #-------------------------------------------------------------------------------
      search_path = 'Search'
      case_results_path = 'caseResults'
      case_html_path = 'caseResultsHtml'
      html_path = 'performScore'

      table_tr0 = ''
  
      html = Template_mixin()
      
      #数据

      dest_scorePath = web_Path + class_type + '/' + test_platform + '/' + test_type + '/' + search_path + '/' + html_path 

      iniFilePre = test_case + '_'
      iniFileEnd = '.ini'

      htmlFileEnd = '.html'

      iniFileName = web_Path + class_type + '/' + test_platform + '/' + test_type + '/' + search_path + '/' +  case_results_path + '/' + test_case + '/' + iniFilePre + str(node_num) + iniFileEnd

      destPath = web_Path + class_type + '/' + test_platform + '/' + test_type + '/' + search_path + '/'

      test_dir = destPath + case_html_path + '/' + test_case
      mkdirlambda =lambda x: os.makedirs(x) if not os.path.exists(x)  else True  # 目录是否存在,不存在则创建
      mkdirlambda(test_dir)

      htmlFileName = test_dir + '/' + iniFilePre + str(node_num) + htmlFileEnd
 
      print('--------------------------')
      print(htmlFileName)
      print('--------------------------')
      #sys.exit(0)

      #dicts = {}
      dicts = OrderedDict() #需要字典按照自定义方式进行排序，否则使用dicts = {}是乱序

      result_code = read_iniFile(iniFileName,dicts)
      for k,v in dicts.items():
           input_path = web_Path + class_type + '/' + backup_path + '/' + test_platform + '/' + test_type + '/' + k + '/Detail/LogInfo/' + test_case
           input_name = 'Node' + node_num + '_'
           ret_code,ret_Str = get_fileName(input_path,input_name)
           file_path = '../../../../../' + backup_path + '/' + test_platform + '/' + test_type + '/' + k + '/Detail/LogInfo/' + test_case + '/' + ret_Str
           #table_td = html.TABLE_TMPL_TOTAL % dict(version=k,result_val=v,log_filepath=file_path)
           #table_tr0 += table_td

      #-------------------------------------------------------------------
      #测试用例:iozone
      #-------------------------------------------------------------------
      case_name = 'iozone'
      href_path = '/Results/Server/7A_2way/OS/Search/performScore'
      table_iozone = html.TABLE_TMPL_TOTAL_ONE % dict(case_name=case_name,href_path=href_path)

      #-------------------------------------------------------------------
      #测试用例:stream
      #-------------------------------------------------------------------
      case_name_1 = 'stream-1core'
      case_name_2 = 'stream-ncore'
      href_path_1 = '/Results/Server/7A_2way/OS/Search/performScore'
      href_path_2 = '/Results/Server/7A_2way/OS/Search/performScore'
      table_stream = html.TABLE_TMPL_TOTAL_TWO % dict(case_name_1=case_name_1,case_name_2=case_name_2,href_path_1=href_path_1,href_path_2=href_path_2)


      #-------------------------------------------------------------------
      #测试用例:spec2000单核多核以及spec2006单核与多核
      #-------------------------------------------------------------------
      table_2 = ''
      list_case = ['spec2000-1core', 'spec2000-ncore','spec2006-1core','spec2006-ncore']
      for name in list_case:
          case_name_1 = name + ':CFP'
          case_name_2 = name + ':CINT'
          href_path_1 = '/Results/Server/7A_2way/OS/Search/performScore'
          href_path_2 = '/Results/Server/7A_2way/OS/Search/performScore'
          table_tmp = html.TABLE_TMPL_TOTAL_TWO % dict(case_name_1=case_name_1,case_name_2=case_name_2,href_path_1=href_path_1,href_path_2=href_path_2)
          table_2 += table_tmp
          
      #-------------------------------------------------------------------
      #测试用例:UnixBench
      #不同机器执行的线程数不一定，需要判断
      #-------------------------------------------------------------------
      list_thread_count = ['1', '2']
      name_base = 'UnixBench'
      for num in list_thread_count:
          case_name = name_base + '_' + num + 'thread'
          href_path = '/Results/Server/7A_2way/OS/Search/performScore'
          table_tmp = html.TABLE_TMPL_TOTAL_1 % dict(case_name=case_name,href_path=href_path)
          table_tr0 += table_tmp

      #-------------------------------------------------------------------
      #测试用例:SpecJvm2008
      #-------------------------------------------------------------------
      case_name = 'SpecJvm2008'
      href_path = '/Results/Server/7A_2way/OS/Search/performScore'
      table_SpecJvm2008 = html.TABLE_TMPL_TOTAL_ONE % dict(case_name=case_name,href_path=href_path)


      output = html.HTML_TMPL % dict(table_tr_UnixBench = table_tr0,case_name=test_case,table_iozone=table_iozone,table_stream=table_stream,table_2=table_2,table_SpecJvm2008=table_SpecJvm2008)
  

      #-------------------------------------------------------------------
      #生成html文件
      #-------------------------------------------------------------------
      html_name = 'score_history.html'
      #filename = dest_scorePath + '/' + html_name
      filename = os.path.join(dest_scorePath,html_name)
   
      print(filename)
   
      with open(filename, 'w') as f:
          f.write(output.encode('utf8'))
  
  
      webbrowser.open(filename,new = 1)

  except Exception as E:
      print('str(e):', str(E))
      sys.exit(1)

