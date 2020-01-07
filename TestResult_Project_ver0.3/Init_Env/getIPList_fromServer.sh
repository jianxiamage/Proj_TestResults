#!/bin/bash

#--------------------------------------------------------------------------------------------------
#同步远程服务器的ip列表目录到本地目录
#lftp -u username,password -e "mirror --delete --only-newer --verbose 远程目录 本地目录" ftpsite
#--------------------------------------------------------------------------------------------------
IP_Server=$(cat IP_Server.txt)
dir_Server=$(cat Dir_Server.txt)
dir_Local=$(cat Dir_Local.txt)
#--------------------------------------------------------------------------------------------------

#示例:
#lftp -e "mirror --delete --only-newer --verbose /tmp/AutoTest/IP_List IP_List;exit" ${IP_Server}
#lftp -e "mirror --delete --only-newer --verbose ${dir_Server} ${dir_Local};exit" ${IP_Server}
#实际执行时,不需要参数--only-newer,因为远程机器上的文件可能没有本地新，但还是需要下载远程同名文件

#实际执行
lftp -e "mirror --delete --verbose ${dir_Server} ${dir_Local};exit" ${IP_Server}

