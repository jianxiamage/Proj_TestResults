#!/usr/bin/env python
# -*- coding=utf-8 -*-
import  sys
import  time,os
import webbrowser
import traceback

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
    seg='<tr bgcolor="SeaGreen">\
    <td align="center">{}</td>\
    <td align="center">{}</td>\
    <td align="center">{}</td>\
    <td align="center">{}</td>\
    <td align="center">{}</td>\
    <td align="center">{}</td>\
    <td align="center">{}</td>\
    <td align="center">{}</td>\
    <td align="center">{}</td>\
    <td align="center">{}</td>\
    <td align="center">{}</td>\
    <td align="center">{}</td>\
    <td align="center">{}</td>\
    '.format(*locls)
    #{}</td><td align="center">{}</td><td align="center">{}</td></tr>\n
    return seg

def fill_data(locls):
# ======================= 表格字段 ======================
    seg='<tr bgcolor="LightGrey">\
    <td align="center">{}</td>\
    <td align="center">{}</td>\
    <td align="center">{}</td>\
    <td align="center">{}</td>\
    <td align="center">{}</td>\
    <td align="center">{}</td>\
    <td align="center">{}</td>\
    <td align="center">{}</td>\
    <td align="center">{}</td>\
    <td align="center">{}</td>\
    <td align="center">{}</td>\
    <td align="center">{}</td>\
    <td align="center">{}</td>\
    '.format(*locls)
    #{}</td><td align="center">{}</td><td align="center">{}</td></tr>\n
    return seg

#------------------------------------------

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
            <p class='attribute'><strong>测试节点编号: </strong> [%(node_num)s]</p>
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
      test_case = sys.argv[4]
      input_type = sys.argv[5]
      node_num = sys.argv[6]
      #-------------------------------------------------------------------------------
      search_Dir='Search'
      case_results_path = 'performScore'
      #html_path = 'performScoreHtml'
      html_path = 'performScore'

      htmlFileEnd = '.html'


      table_tr0 = ''
      table_tr1=""
  
      html = Template_mixin()
      
      #数据

      #------------------------------------------------------------------------------------
      #拼接目标文件名
      caseDir='UnixBench' #区分单线程和多线程
      destPath = web_Path + class_type + '/' + test_platform + '/' + test_type + '/' + search_Dir + '/' + perform_dir + '/' + caseDir
      #------------------------------------------------------------------------------------

      #------------------------------------------------------------------------------------
      #判断目标目录是否存在，如不存在则创建
      mkdirlambda =lambda x: os.makedirs(x) if not os.path.exists(x)  else True  # 目录是否存在,不存在则创建
      mkdirlambda(destPath)
      #------------------------------------------------------------------------------------

      #------------------------------------------------------------------------------------
      #生成的当前节点csv文件路径
      csvFileName = destPath + '/' + test_case + '_' + input_type + '_' + node_num + '.csv'
      htmlFileName = destPath + '/' + test_case + '_' + input_type + '_' +  node_num + htmlFileEnd
      #------------------------------------------------------------------------------------

 
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

      print(table_tr0)

      table_td = fill_data_head(ls[0])
      table_tr0 += table_td
      print(table_tr0)

      for i in range(len(ls)-1):
          #fill_data(ls[i+1])
          table_td_con = fill_data(ls[i+1])
          table_tr1 += table_td_con

      #生成html文件
      output = html.HTML_TMPL % dict(table_tr_Head = table_tr0,table_tr_Content=table_tr1,test_class=class_type,test_type=test_type,test_plat=test_platform,case_name=test_case,node_num=node_num)
  
      #filename=os.path.join(dir,filename)
      filename = htmlFileName
      
      print(filename)
   
      with open(filename, 'w') as f:
          f.write(output.encode('utf8'))
  
  
      #webbrowser.open(filename,new = 1)

  except Exception as E:
      print('str(e):', str(E))
      sys.exit(1)
