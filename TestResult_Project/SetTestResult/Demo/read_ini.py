#!/usr/bin/env python
# -*- coding: utf-8 -*-
import ConfigParser

import sys  #引入模块
Group_num = sys.argv[1]

config = ConfigParser.ConfigParser()
config.readfp(open('ip_list.ini'))
#Group_num=3
#val_num=3
for i in range(1,4):

  sectionName='Group'+ str(Group_num)
  valName='ip_'+ str(i)
  a = config.get(sectionName,valName)
  print a
