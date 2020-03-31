#!/usr/bin/env python
# -*- coding=utf-8 -*-
import  sys
import  time,os
import webbrowser
import ConfigParser
import traceback

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
            <p class='attribute'><strong>测试用例名称: </strong> [%(case_name)s]</p>
            <style type="text/css" media="screen">
        body  { font-family: Microsoft YaHei,Tahoma,arial,helvetica,sans-serif;padding: 20px;}
        </style>
        </head>
        <body>
            <p class='attribute'><strong>测试详情 : </strong> 历史版本执行结果及日志查看</p>

            <table id='result_table' class="table table-condensed table-bordered table-hover">
                <colgroup>
                    <col align='left' />
                    <col align='right' />
                    <col align='right' />
                    <col align='right' />
                </colgroup>
                <tr id='header_row' class="text-center success" style="font-weight: bold;font-size: 14px;">
                    <th>版本名</th>
                    <th>测试结果</th>
                    <th>测试日志</th>
                </tr>
                %(table_tr)s
 
            </table>
        </body>
        </html>"""
    #总数据
    TABLE_TMPL_TOTAL = """
        <tr class='failClass warning'>
            <td>%(version)s</td>
            <td>%(result_val)s</td>
            <td><a href="%(log_filepath)s" target="_blank">查看</a></td>
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
      node_num = sys.argv[5]
      #-------------------------------------------------------------------------------
      #定位历史log目录:
      #input_path=r"/Results/Server/History_Bak/7A_2way/OS/20192001-RC1.mips64/Detail/LogInfo/iozone"
      backup_path = 'History_Bak'
      #-------------------------------------------------------------------------------
      search_path = 'Search'
      case_results_path = 'caseResults'
      case_html_path = 'caseResultsHtml'

      table_tr0 = ''
      table_tr1=""
      table_tr2=""
  
  
      html = Template_mixin()
      
      #数据

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

      dicts = {}
      result_code = read_iniFile(iniFileName,dicts)
      for k,v in dicts.items():
           print('-------k-------------------')
           input_path = web_Path + class_type + '/' + backup_path + '/' + test_platform + '/' + test_type + '/' + k + '/Detail/LogInfo/' + test_case
           input_name = 'Node' + node_num + '_'
           ret_code,ret_Str = get_fileName(input_path,input_name)
           file_path = '../../../../../' + backup_path + '/' + test_platform + '/' + test_type + '/' + k + '/Detail/LogInfo/' + test_case + '/' + ret_Str
           print(input_path)
           print(file_path)
           print(input_name)
           print('---------------------------')
           print(v)
           table_td = html.TABLE_TMPL_TOTAL % dict(version=k,result_val=v,log_filepath=file_path)
           table_tr0 += table_td
  
  
      output = html.HTML_TMPL % dict(table_tr = table_tr0,table_tr2=table_tr1,table_tr3=table_tr2,case_name=test_case)
  
      # 生成html报告
      filename = 'case_history.html'
   
      print(filename)
      #获取report的路径
      #dir= os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),'report')
      dir = 'case_dir'
      #filename=os.path.join(dir,filename)
      filename = htmlFileName
   
      with open(filename, 'w') as f:
          f.write(output.encode('utf8'))
  
  
      #webbrowser.open(filename,new = 1)

  except Exception as E:
      #print('str(Exception):', str(Exception))
      print('str(e):', str(E))
      #print('repr(e):', repr(E))
      #print('traceback.print_exc(): ', traceback.print_exc())
      sys.exit(1)

