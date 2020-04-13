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
perform_dir='performScore'
#------------------------------------------
if sys.getdefaultencoding() != 'utf-8':
    reload(sys)
    sys.setdefaultencoding('utf-8')
#------------------------------------------

def fill_data_head(locls):
# ======================= 表头单独设置=====================
    seg='<tr bgcolor="orange"><td align="center">{}</td><td align="center">\
    {}</td><td align="center">{}</td><td align="center">\
    {}</td><td align="center">{}</td><td align="center">\
    {}</td><td align="center">{}</td><td align="center">\
    '.format(*locls)
    #{}</td><td align="center">{}</td><td align="center">{}</td></tr>\n
    return seg

def fill_data(locls):
# ======================= 表格字段 ======================
    seg='<tr><td align="center">{}</td><td align="center">\
    {}</td><td align="center">{}</td><td align="center">\
    {}</td><td align="center">{}</td><td align="center">\
    {}</td><td align="center">{}</td><td align="center">\
    '.format(*locls)
    #{}</td><td align="center">{}</td><td align="center">{}</td></tr>\n
    return seg

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

            <table id='result_table' class="table table-condensed table-bordered table-hover" align="center">

                <tr bgcolor='orange' align="center">
                %(table_tr_Head)s
                </tr>
                %(table_tr_Content)s
 
            </table>
        </body>
        </html>"""
    #总数据


    TABLE_TMPL_HEAD = """
        <th align="center" width="15%">{}</th>
        <th align="center" width="15%">{}</th>
        <th align="center" width="15%">{}</th>
        <th align="center" width="15%">{}</th>
        <th align="center" width="15%">{}</th>
        <th align="center" width="15%">{}</th>
        <th align="center" width="15%">{}</th>"""
 
if __name__ == '__main__':

  try:

      #---------------------------------------
      test_case = 'iozone'
      #---------------------------------------

      #-------------------------------------------------------------------------------
      #输入参数
      #-------------------------------------------------------------------------------
      test_type = sys.argv[1]
      test_platform = sys.argv[2]
      class_type = sys.argv[3]
      node_num = sys.argv[4]
      #-------------------------------------------------------------------------------
      search_Dir='Search'
      case_results_path = 'performScore'
      #html_path = 'performScoreHtml'
      html_path = 'performScore'

      htmlFileEnd = '.html'


      table_tr0 = ''
      table_tr1=""
      table_tr2=""
  
      html = Template_mixin()
      
      #数据

      #------------------------------------------------------------------------------------
      #拼接目标文件名
      destPath = web_Path + class_type + '/' + test_platform + '/' + test_type + '/' + search_Dir + '/' + perform_dir + '/' + test_case
      #------------------------------------------------------------------------------------

      #------------------------------------------------------------------------------------
      #判断目标目录是否存在，如不存在则创建
      mkdirlambda =lambda x: os.makedirs(x) if not os.path.exists(x)  else True  # 目录是否存在,不存在则创建
      mkdirlambda(destPath)
      #------------------------------------------------------------------------------------

      #------------------------------------------------------------------------------------
      #生成的当前节点csv文件路径
      csvFileName = destPath + '/' + test_case + '_' + node_num + '.csv'
      HtmlTableFileName = destPath + '/' + test_case + '_' + node_num + '.html'
      #------------------------------------------------------------------------------------

      htmlFileName = destPath + '/' + test_case + '_' + node_num + htmlFileEnd
 
      print('---------生成html文件-----------------')
      print(csvFileName)
      print(htmlFileName)
      print('---------生成html文件-----------------')

      fr=open(csvFileName,"r")
      ls=[]
      for line in fr:
          line=line.replace("\n","")
          ls.append(line.split(","))
      fr.close()



      MaxCount=3  #并发节点最大为3个
      #table_td = html.TABLE_TMPL_HEAD % dict(node_num=node_num,file_path=file_path)
      #table_td = html.TABLE_TMPL_HEAD
      #table_tr0 += table_td.format(*ls[0])

      print(table_tr0)

      table_td = fill_data_head(ls[0])
      table_tr0 += table_td
      print(table_tr0)

      for i in range(len(ls)-1):
          #fill_data(ls[i+1])
          table_td_con = fill_data(ls[i+1])
          table_tr1 += table_td_con


      print(table_tr1)
      #sys.exit(0)
      #生成html文件
      output = html.HTML_TMPL % dict(table_tr_Head = table_tr0,table_tr_Content=table_tr1,test_class=class_type,test_type=test_type,test_plat=test_platform,case_name=test_case)
  
      #filename=os.path.join(dir,filename)
      filename = htmlFileName
      
      print(filename)
      #sys.exit(0)
   
      with open(filename, 'w') as f:
          f.write(output.encode('utf8'))
  
  
      webbrowser.open(filename,new = 1)

  except Exception as E:
      print('str(e):', str(E))
      sys.exit(1)

