#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys  #引入模块
import os
import traceback
import ConfigParser
import io
from collections import OrderedDict

reload(sys)
sys.setdefaultencoding('utf-8') 

#------------------------------------------
web_Path='/Results/'
detailDir='Detail'
search_Dir='Search'
perform_dir='performScore'
PointsPath='Points_Files'
#------------------------------------------

#防止自动将ini文件中的键名转换成小写
class myconf(ConfigParser.ConfigParser):
    def __init__(self,defaults=None):
        ConfigParser.ConfigParser.__init__(self,defaults=None)
    def optionxform(self, optionstr):
        return optionstr

def get_list_from_file(input_file, list_data=[]):
    """将文件内容写入List"""
    try:

        i=1
        with io.open(input_file, mode= 'rt', encoding='utf-8') as file_handler:
            # 通过迭代器，遍历csv文件中的所有样本
            lines = file_handler.readlines()
            #使用islice的原因是跳过csv文件第一行
            for line in lines:
               res = ''.join(line).strip('\n')
               #print(res)
               list_data.append(res)
    except Exception as e:
        print("操作出现错误：{}".format(e))


#将ini文件中的section内容写入csv文件开头，用以标明各个字段名称
#注意的是写入section行到csv时是覆盖模式"w")
def read_iniHead(inputFile,outputFile):

    section = 'System Benchmarks Index Score'
    config = myconf()
    config.readfp(open(inputFile))

    f = open(outputFile,"w")

    #sections = config.sections()
    #sections_Str = ','.join(sections).strip(except_section)
    sections_Str = section
    print(sections_Str)
    f.write('version,' + sections_Str + '\n')


#将各个字段的值写入csv文件
def read_ini(inputFile,outputFile,Tag,input_type):

    config = myconf()
    config.readfp(open(inputFile))

    f = open(outputFile,"a")

    section = 'System Benchmarks Index Score'

    j=1
    dicts = OrderedDict() #字典中只有一个元素，直接使用dicts = {}也可以

    for option in config.options(section):
        dicts[option] = config.get(section, option)
        value = dicts[option]
        #print 'section:%s,option:%s,value:%s' %(section,option,value)
        print(value)
        j = j + 1

    print('===============================================')
    values = dicts.values()
    values_Str = ','.join(values)
    print(values_Str)
    f.write(Tag + ',' + values_Str+'\n')

    print('===============================================')

    return 0



if __name__=='__main__':

  try:

      #---------------------------------------
      #input_type = 'Benchmarks'
      #---------------------------------------
      #输入参数
      #---------------------------------------
      test_type = sys.argv[1]
      test_platform = sys.argv[2]
      class_type = sys.argv[3]
      test_case = sys.argv[4]
      input_type = sys.argv[5]
      node_num = sys.argv[6]
      #---------------------------------------
      dirList_file = web_Path + class_type + '/' + test_platform + '/' + test_type + '/' + search_Dir + '/' + 'HistoryDirList.file'
      print(dirList_file)
      #---------------------------------------

      #------------------------------------------------------------------------------------
      #拼接目标文件名
      caseDir='UnixBench' #区分单线程和多线程
      ResultIniPath = web_Path + class_type + '/' + test_platform + '/' + test_type + '/' + detailDir + '/' + caseDir + '/' + PointsPath
      destPath = web_Path + class_type + '/' + test_platform + '/' + test_type + '/' + search_Dir + '/' + perform_dir + '/' + caseDir
      iniFilePre = test_case + '_'
      iniFileEnd = '.ini'
      #------------------------------------------------------------------------------------

      #------------------------------------------------------------------------------------
      #判断目标目录是否存在，如不存在则创建
      mkdirlambda =lambda x: os.makedirs(x) if not os.path.exists(x)  else True  # 目录是否存在,不存在则创建
      mkdirlambda(destPath)
      #------------------------------------------------------------------------------------

      #------------------------------------------------------------------------------------
      iniFileName = ResultIniPath + '/' + iniFilePre + node_num + iniFileEnd
      csvFileName = destPath + '/' + test_case + '_' + input_type + '_' + node_num + '.csv'
      print(iniFileName)
      print('------csvFile------------')
      print(csvFileName)
      print('------csvFile------------')
      #print('------------------')
      #print(ResultIniPath)
      #print(csvFileName)
      #print('------------------')
      #------------------------------------------------------------------------------------


      #------------------------------------------------------------------------------------
      #历史版本目录列表文件中的内容存储到list
      list_data=[]
      get_list_from_file(dirList_file,list_data)
      #------------------------------------------------------------------------------------

      #------------------------------------------------------------------------------------
      #表头
      result_code = read_iniHead(iniFileName,csvFileName)
      #------------------------------------------------------------------------------------

      #------------------------------------------------------------------------------------
      #写具体内容:本测试用例某个节点各个历史版本的详细跑分情况
      for i, val in enumerate(list_data):
         print ("序号:[%s], 版本:[%s]" % (i + 1, val))
         test_ver = val
         result_code = read_ini(iniFileName,csvFileName,test_ver,input_type)
      #sys.exit(0)
      #------------------------------------------------------------------------------------
      

  except Exception as E:
      print('str(e):', str(E))
      sys.exit(1)
