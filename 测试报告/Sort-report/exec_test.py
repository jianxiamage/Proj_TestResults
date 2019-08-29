#!/usr/bin/env python
#coding=utf-8

import sys  #引入模块
import os
import traceback

test_dir = "./testcase/"

def find_pyfile_and_Import(rootDir):

    if os.path.exists(rootDir):

       arr = rootDir.split("/")
       print('----------arr = rootDir.split-----------')
       print(arr)
       print('----------arr = rootDir.split-----------')

       pathDir= ""

       for path in arr:

           pathDir = pathDir + path + "/"
           if not os.path.exists( pathDir + "/__init__.py" ):
               f = open(pathDir + "/__init__.py",'w')
               f.close()

    list_dirs = os.walk(rootDir)
    print('===========================')
    print(list_dirs)
    print('===========================')
    for dirName,subdirList,fileList in list_dirs:

         for f in fileList:

            file_name = f

            if file_name[0:5] == "Test_" and file_name[-3:] == ".py":

                if dirName[-1:] != "/":

                    impPath = dirName.replace("/",".")[2:].replace("\\",".")

                else:

                    impPath = dirName.replace("/",".")[2:-1]

                if impPath != "":

                    exe_str = "from" + impPath + " import " + file_name[0:-3]

                else:

                    exe_str = " import " + file_name[0:-3]

                exec(exe_str,globals())




if __name__=='__main__':

  try:
      curDir = os.getcwd()
      print(curDir)
      find_pyfile_and_Import(curDir)

  except Exception as E:
      #print('str(Exception):', str(Exception))
      print('str(e):', str(E))
      #print('repr(e):', repr(E))
      #print('traceback.print_exc(): ', traceback.print_exc())
