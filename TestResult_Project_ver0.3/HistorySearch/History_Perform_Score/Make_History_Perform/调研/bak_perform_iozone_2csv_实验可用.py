#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys  #引入模块
import os
import traceback
import ConfigParser

reload(sys)
sys.setdefaultencoding('utf-8') 

#------------------------------------------
web_Path='/Results/'
detailDir='Detail'
search_Dir='Search'
perform_dir='performScore'
PointsPath='Points_Files'
#------------------------------------------
section = 'EXT3 File System'
#------------------------------------------

#防止自动将ini文件中的键名转换成小写
class myconf(ConfigParser.ConfigParser):
    def __init__(self,defaults=None):
        ConfigParser.ConfigParser.__init__(self,defaults=None)
    def optionxform(self, optionstr):
        return optionstr

#将ini文件中的section内容写入csv文件开头，用以标明各个字段名称
#注意的是写入section行到csv时是覆盖模式"w")
def read_iniHead(inputFile,outputFile):

    config = myconf()
    config.readfp(open(inputFile))

    f = open(outputFile,"w")

    options = config.options(section)
    optionStr = ','.join(options)
    print(optionStr)
    f.write('version,node_num,' + optionStr + '\n')

#将各个字段的值写入csv文件
def read_ini(inputFile,outputFile,num,Tag):

    config = myconf()
    config.readfp(open(inputFile))

    f = open(outputFile,"a")

    j=1
    dicts = {}
    #section = 'EXT3 File System'
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
    f.write(Tag + ',' + num + ',' + values_Str+'\n')

    print('===============================================')

    return 0

if __name__=='__main__':

  try:

      #输入参数
      test_type = sys.argv[1]
      test_platform = sys.argv[2]
      class_type = sys.argv[3]
      test_case = sys.argv[4]
      test_ver = sys.argv[5]
      node_num = sys.argv[6]


      #拼接目标文件名
      #ResultIniPath = web_Path + test_type + '/' + test_platform + '/' + detailDir + '/' + test_case + '/' + PointsPath
      ResultIniPath = web_Path + class_type + '/' + test_platform + '/' + test_type + '/' + detailDir + '/' + test_case + '/' + PointsPath
      destPath = web_Path + class_type + '/' + test_platform + '/' + test_type + '/' + search_Dir + '/' + perform_dir + '/' + test_case
      iniFilePre = test_case + '_'
      iniFileEnd = '.ini'

      iniFileName = ResultIniPath + '/' + iniFilePre + node_num + iniFileEnd
      csvFileName = destPath + '/' + test_case + '_' + node_num + '.csv'
      print('------------------')
      print(ResultIniPath)
      print(csvFileName)
      print('------------------')

      result_code = read_iniHead(iniFileName,csvFileName)

      result_code = read_ini(iniFileName,csvFileName,str(node_num),test_ver)
      sys.exit(0)
      

  except Exception as E:
      #print('str(Exception):', str(Exception))
      print('str(e):', str(E))
      #print('repr(e):', repr(E))
      #print('traceback.print_exc(): ', traceback.print_exc())
      sys.exit(1)
