#!/usr/bin/python
# -*- coding: UTF-8 -*-
"""
程序说明:
其中关于从csv文件中获取数据，并存入数据库的方法，现已修正为从csv文件中读入到list，
再从list中依此循环写入数据库中，
原来的逻辑是:直接从csv文件读取数据写入数据库，对于表名是变量的情况不方便处理
"""

import sys
import os
import traceback

from itertools import islice

import MySQLdb
import io

#------------------------------------------
ResultPath='/data/'
detailDir='Detail'
PointsPath='Points_Files'
#------------------------------------------

class MySQLDB():

    def __init__(self, host, port, user, passwd, db, charset):
        # 建立数据库连接
        self.conn = MySQLdb.connect(
            host=host,
            port=port,
            user=user,
            passwd=passwd,
            db=db,
            charset=charset
        )

        self.conn = MySQLdb.connect("localhost", "autotest", "loongson", "AutoTest", charset='utf8' )


        # 通过 cursor() 创建游标对象，并让查询结果以字典格式输出
        self.cur = self.conn.cursor()

    def __del__(self): # 对象资源被释放时触发，在对象即将被删除时的最后操作
        # 关闭游标
        self.cur.close()
        # 关闭数据库连接
        self.conn.close()

    def get_data_from_csv(self, input_file, list_data=[]):
        """生成csv文件,准备写入数据库"""
        try:

            i=1
            with io.open(input_file, mode= 'rt', encoding='utf-8') as file_handler:
                # 通过迭代器，遍历csv文件中的所有样本
                lines = file_handler.readlines()
                #使用islice的原因是跳过csv文件第一行
                for line in islice(lines, 1, None):
                   #res = ''.join(line).strip('\n').split(',')
                   res = ''.join(line).strip('\n').split(',')
                   #print('-------------------------------------')
                   #print(res)
                   list_data.append(res)
        except Exception as e:
            print("操作出现错误：{}".format(e))


    def insertData_db(self, table_name, list_data):
        """更新/插入/删除"""
        try:

            i=1
            for line in list_data:
                 sql = '''
                 insert into %s(Tag,case_name,node_num,value)
                 values('%s','%s', '%s', '%s')
                 '''  % (table_name,line[0],line[1],line[2],line[3])
                 self.cur.execute(sql)
                 #print('=====================================================')
                 #print(i)
                 i = i + 1
            
            # 使用 execute() 执行sql
            #self.cur.execute(sql)
            # 提交事务
            self.conn.commit()
        except Exception as e:
            print("操作出现错误：{}".format(e))
            # 回滚所有更改
            self.conn.rollback()

    def select_db(self, sql):
        """查询"""
        # 使用 execute() 执行sql
        self.cur.execute(sql)
        # 使用 fetchall() 获取查询结果
        data = self.cur.fetchall()
        return data

    def execute_db(self, sql):
        """更新/插入/删除"""
        try:
            # 使用 execute() 执行sql
            self.cur.execute(sql)
            # 提交事务
            self.conn.commit()
        except Exception as e:
            print("操作出现错误：{}".format(e))
            # 回滚所有更改
            self.conn.rollback()

if __name__ == '__main__':

    db = MySQLDB("localhost", 3306, "autotest", "loongson", "AutoTest","utf8")

    try:

        test_type = sys.argv[1]
        test_platform = sys.argv[2]
        test_Tag = sys.argv[3]
    
        #---------------------------------------------------------------------
        #拼接目标文件名
        csvFile='TestResults.csv'
        ResultIniPath = ResultPath + str(test_type) + '/' + str(test_platform)
        csvFileName = ResultIniPath + '/' + csvFile
        #---------------------------------------------------------------------
    
        #---------------------------------------------------------------------
        #创建数据表
        table_name = 'results_BaseInfo_' + test_Tag
        sql_create = '''
        create table if not exists %s
        (
          id int(10) NOT NULL AUTO_INCREMENT,
          Tag varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci,
          case_name varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci,
          node_num varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci,
          value varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci,
          PRIMARY KEY (id)
        ) CHARACTER SET utf8 COLLATE utf8_general_ci;
        ''' %(table_name)
        #---------------------------------------------------------------------
        db.execute_db(sql_create)
        #---------------------------------------------------------------------

        #---------------------------------------------------------------------
        #清空数据表
        #trunc_sql = 'truncate table score_UnixBench_1thread'
        sql_delete = "delete from %s where Tag ='%s'" %(table_name, test_Tag)
        #---------------------------------------------------------------------
 
        #---------------------------------------------------------------------
        print('清理旧数据,准备重新插入...')
        #db.execute_db(trunc_sql)
        db.execute_db(sql_delete)

        #------------------------------------------------------------------------------
        #在删除数据后，会造成表中的自增字段序号不连续，
        #解决方法是truancate或创建临时表备份后重新创建新表,但都缺点明显
        #因此以下操作是先将id删除，再重新加入
        #------------------------------------------------------------------------------
        sql_dropID = "ALTER TABLE %s DROP column id" %(table_name)
        db.execute_db(sql_dropID)
        sql_addID = "ALTER TABLE %s ADD id int first" %(table_name)
        db.execute_db(sql_addID)
        sql_addIDAttr = "ALTER TABLE %s change id id int NOT NULL AUTO_INCREMENT primary key" %(table_name)
        db.execute_db(sql_addIDAttr)
        #------------------------------------------------------------------------------

        #------------------------------------------------------------------------------
        #旧的方法:
        #读取csv文件插入表数据
        #sql_insert = '''
        #insert into score_UnixBench_1thread(Tag,node_num,test_option,ref_data,score) values(%s, %s, %s, %s, %s);
        #'''
        #------------------------------------------------------------------------------

        #------------------------------------------------------------------------------
        #新的方法:
        #读取csv文件到列表
        list_data=[]
        db.get_data_from_csv(csvFileName,list_data)

        print('插入数据开始...')
        db.insertData_db(table_name,list_data)
        print('插入数据完成.')

    except Exception as E:
        #print('str(Exception):', str(Exception))
        print('str(e):', str(E))
        #print('repr(e):', repr(E))
        #print('traceback.print_exc(): ', traceback.print_exc())
        sys.exit(1)
