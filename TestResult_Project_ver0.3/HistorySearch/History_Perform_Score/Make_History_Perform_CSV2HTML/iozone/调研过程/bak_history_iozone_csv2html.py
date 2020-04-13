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

if __name__=='__main__':

  try:

      #---------------------------------------
      test_case = 'iozone'
      #---------------------------------------
      #输入参数
      #---------------------------------------
      test_type = sys.argv[1]
      test_platform = sys.argv[2]
      class_type = sys.argv[3]
      node_num = sys.argv[4]
      #---------------------------------------
      dirList_file = web_Path + class_type + '/' + test_platform + '/' + test_type + '/' + search_Dir + '/' + 'HistoryDirList.file'
      print(dirList_file)
      #---------------------------------------

      #------------------------------------------------------------------------------------
      #拼接目标文件名
      Bak_Dir = 'History_Bak'
      ResultIniPath = web_Path + class_type + '/' + test_platform + '/' + test_type + '/' + detailDir + '/' + test_case + '/' + PointsPath
      Bak_IniPath = web_Path + class_type + '/' + Bak_Dir + '/'+ test_platform + '/' + test_type
      destPath = web_Path + class_type + '/' + test_platform + '/' + test_type + '/' + search_Dir + '/' + perform_dir + '/' + test_case
      iniFilePre = test_case + '_'
      iniFileEnd = '.ini'
      #------------------------------------------------------------------------------------

      #------------------------------------------------------------------------------------
      #判断目标目录是否存在，如不存在则创建
      mkdirlambda =lambda x: os.makedirs(x) if not os.path.exists(x)  else True  # 目录是否存在,不存在则创建
      mkdirlambda(destPath)
      #------------------------------------------------------------------------------------

      #------------------------------------------------------------------------------------
      #当前测试ini文件路径
      iniFileName = ResultIniPath + '/' + iniFilePre + node_num + iniFileEnd
      #生成的当前节点csv文件路径
      csvFileName = destPath + '/' + test_case + '_' + node_num + '.csv'
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
         curIniFile = Bak_IniPath + '/' + test_ver + '/' + detailDir + '/' + test_case + '/' + PointsPath + '/' + iniFilePre + node_num + iniFileEnd
         result_code = read_ini(curIniFile,csvFileName,test_ver)
      #sys.exit(0)
      #------------------------------------------------------------------------------------
      

  except Exception as E:
      print('str(e):', str(E))
      sys.exit(1)
