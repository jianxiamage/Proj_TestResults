#!/usr/bin/env python
# coding:utf-8

import sys  #引入模块
import os
import traceback

import ConfigParser
from threading import Lock


def lock(func):
    def wrapper(self, *args, **kwargs):  # self变量,可以调用对象的相关方法
        with Lock():
            return func(self, *args, **kwargs)

    return wrapper


class Config(object):
    """
        读写ini配置文件
    """

    def __init__(self, path):
        self.path = path

        #if not os.path.exists(self.path):
        #    raise IOError('file {} not found!'.format(self.path))
        try:

            self.cf = ConfigParser.ConfigParser()
            self.cf.read(self.path)
        except Exception as e:
            raise IOError(str(e))

    def get(self, section, key):
        """读取配置文件数据"""
        return self.cf.get(section, key)

    @lock
    def set(self, section, key, value):
        """向配置文件写入数据"""
        if not self.cf.has_section(section):
           print("No section error!%s" %(section))
           return 1
        self.cf.set(section, key, value)
        with open(self.path, 'w') as f:
            self.cf.write(f)

    @lock
    def add(self, section, key, value):
        """向配置文件添加新的[节],写入数据"""
        try:
            if not self.cf.has_section(section):
               
               #print("No section:[%s]" %(section))
               self.cf.add_section(section)

            self.set(section, key, value)

        except Exception as e:
            raise IOError(str(e))

if __name__ == "__main__":

  try:
  
      ResultPath='/data/'
      TestIniPath='TestIniDir'
      detailPath='Detail'
      test_case_type = sys.argv[1]
      test_case_platform = sys.argv[2]
      test_case = sys.argv[3]
      node_num = sys.argv[4]
      test_value = sys.argv[5]
  

      #IniFile = ResultPath + '/' + test_case_type + test_case_platform + test_case + '.ini'
      IniPath = os.path.join(ResultPath,test_case_type,test_case_platform,detailPath,TestIniPath)
      #print("IniFile path is:[%s]" %(IniPath))
      isExists=os.path.exists(IniPath)
      if not isExists:
        os.makedirs(IniPath) 
        #print IniPath +' created success.'

      IniFileName = test_case + '.ini'
      IniFile = os.path.join(IniPath,IniFileName)
      #print("IniFile Name is:[%s]" %(IniFile))

      test_key = 'node_' + str(node_num)
      #config = Config("aa.ini")
      config = Config(IniFile)
      val = config.add(test_case,test_key,test_value)
  
  except Exception as E:
      #print('str(Exception):', str(Exception))
      print('str(e):', str(E))
      #print('repr(e):', repr(E))
      #print('traceback.print_exc(): ', traceback.print_exc())

