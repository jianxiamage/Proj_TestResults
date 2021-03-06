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
            <h2 style="font-family: Microsoft YaHei">性能测试跑分结果历史记录</h2>
            <p class='attribute'><strong>测试用例名称: </strong> [%(case_name)s]</p>
            <p class='attribute'><strong>测试分类: </strong> [%(test_class)s]</p>
            <p class='attribute'><strong>测试类型: </strong> [%(test_type)s]</p>
            <p class='attribute'><strong>测试平台: </strong> [%(test_plat)s]</p>
            <style type="text/css" media="screen">
        body  { font-family: Microsoft YaHei,Tahoma,arial,helvetica,sans-serif;padding: 20px;}
        </style>
        </head>
        <body>

                <p class='attribute'><strong> 网页查看: </strong></p>
            <table id='result_table' class="table table-condensed table-bordered table-hover">
                <colgroup>
                    <col align='left' />
                    <col align='right' />
                    <col align='right' />
                    <col align='right' />
                </colgroup>
                <tr id='header_row' class="text-center success" style="font-weight: bold;font-size: 14px;">
                    <th>节点序号</th>
                    <th>性能指标一</th>
                    <th>性能指标二</th>
                    <th>性能指标三</th>
                    <th>性能指标四</th>
                </tr>
                %(table_tr_html)s
 
            </table>

                <p class='attribute'><srong> 表格查看: </strong></p>
            <table id='result_table' class="table table-condensed table-bordered table-hover">
                <colgroup>
                    <col align='left' />
                    <col align='right' />
                    <col align='right' />
                    <col align='right' />
                </colgroup>
                <tr id='header_row' class="text-center success" style="font-weight: bold;font-size: 14px;">
                    <th>节点序号</th>
                    <th>性能指标一</th>
                    <th>性能指标二</th>
                    <th>性能指标三</th>
                    <th>性能指标四</th>
                </tr>
                %(table_tr)s
 
            </table>


        </body>
        </html>"""
    #总数据
    TABLE_TMPL_CSV = """
        <tr> 
            <td>%(node_num)s</td>
            <td><a href="%(BASELINE_path)s" target="_blank">BASELINE</a></th>
            <td><a href="%(RESULT_path)s" target="_blank">RESULT</a></td>
            <td><a href="%(INDEX_path)s" target="_blank">INDEX</a></td>
            <td><a title="System Benchmarks Index Score" href="%(Benchmarks_path)s" target="_blank">Benchmarks</a></td>
        </tr>"""

    TABLE_TMPL_HTML = """
        <tr> 
            <td>%(node_num)s</td>
            <td><a href="%(BASELINE_path_html)s" target="_blank">BASELINE</a></th>
            <td><a href="%(RESULT_path_html)s" target="_blank">RESULT</a></td>
            <td><a href="%(INDEX_path_html)s" target="_blank">INDEX</a></td>
            <td><a title="System Benchmarks Index Score" href="%(Benchmarks_path_html)s" target="_blank">Benchmarks</a></td>
        </tr>"""

 
if __name__ == '__main__':

  try:

      #-------------------------------------------------------------------------------
      #输入参数
      #-------------------------------------------------------------------------------
      test_type = sys.argv[1]
      test_platform = sys.argv[2]
      class_type = sys.argv[3]
      test_case = sys.argv[4]
      test_mode = sys.argv[5]
      #-------------------------------------------------------------------------------
      search_path = 'Search'
      case_results_path = 'performScore'
      html_path = 'performScoreHtml'


      table_tr0 = ''
      table_tr_html = ''
      table_tr1=""
  
      html = Template_mixin()
      
      #数据

      iniFilePre = test_case + '_'
      iniFileEnd = '.ini'

      csvFilePre = test_case + '_'
      csvFileEnd = '.csv'

      htmlFileEnd = '.html'

      #拼接csv文件路径与目标html文件路径
      srcPath = web_Path + class_type + '/' + test_platform + '/' + test_type + '/' + search_path + '/' +  case_results_path + '/' + test_case
      destPath = web_Path + class_type + '/' + test_platform + '/' + test_type + '/' + search_path + '/'
      dest_scorePath = web_Path + class_type + '/' + test_platform + '/' + test_type + '/' + search_path + '/' + html_path + '/' + test_case

      mkdirlambda =lambda x: os.makedirs(x) if not os.path.exists(x)  else True  # 目录是否存在,不存在则创建
      mkdirlambda(dest_scorePath)

      htmlFileName = dest_scorePath + '/' + test_case + '_' + test_mode + htmlFileEnd

 
      print('---------生成html文件-----------------')
      print(htmlFileName)
      print('---------生成html文件-----------------')
      #sys.exit(0)

      MaxCount=3  #并发节点最大为3个
      Relative_Path = '../../' + case_results_path + '/' + test_case
      for i in range(1,MaxCount+1):
        BASELINE_path = Relative_Path + '/' + csvFilePre + test_mode + '_BASELINE_' + str(i) + csvFileEnd
        RESULT_path = Relative_Path + '/' + csvFilePre + test_mode + '_RESULT_' + str(i) + csvFileEnd
        INDEX_path = Relative_Path + '/' + csvFilePre + test_mode + '_INDEX_' + str(i) + csvFileEnd
        Benchmarks_path = Relative_Path + '/' + csvFilePre + test_mode + '_Benchmarks_' + str(i) + csvFileEnd
        table_td = html.TABLE_TMPL_CSV % dict(node_num=i,BASELINE_path=BASELINE_path,RESULT_path=RESULT_path,INDEX_path=INDEX_path,Benchmarks_path=Benchmarks_path)
        table_tr0 += table_td


      for i in range(1,MaxCount+1):
        BASELINE_path_html = Relative_Path + '/' + csvFilePre + test_mode + '_BASELINE_' + str(i) + htmlFileEnd
        RESULT_path_html = Relative_Path + '/' + csvFilePre + test_mode + '_RESULT_' + str(i) + htmlFileEnd
        INDEX_path_html = Relative_Path + '/' + csvFilePre + test_mode + '_INDEX_' + str(i) + htmlFileEnd
        Benchmarks_path_html = Relative_Path + '/' + csvFilePre + test_mode + '_Benchmarks_' + str(i) + htmlFileEnd
        table_td_html = html.TABLE_TMPL_HTML % dict(node_num=i,BASELINE_path_html=BASELINE_path_html,RESULT_path_html=RESULT_path_html,INDEX_path_html=INDEX_path_html,Benchmarks_path_html=Benchmarks_path_html)
        table_tr_html += table_td_html

      #生成html文件
      output = html.HTML_TMPL % dict(table_tr = table_tr0,table_tr_html=table_tr_html,test_class=class_type,test_type=test_type,test_plat=test_platform,case_name=test_case)
  
      #filename=os.path.join(dir,filename)
      filename = htmlFileName
      
      print(filename)
      #sys.exit(0)
   
      with open(filename, 'w') as f:
          f.write(output.encode('utf8'))
  
  
      #webbrowser.open(filename,new = 1)

  except Exception as E:
      print('str(e):', str(E))
      sys.exit(1)

