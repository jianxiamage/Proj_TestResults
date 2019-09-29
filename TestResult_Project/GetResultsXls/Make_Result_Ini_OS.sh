#!/bin/bash

#if [ $# -ne 3 ];then
# echo "usage: $0 TestType Platform TestCase" 
# exit 1
#fi

#----------------------------------------------------------------------------------------
#测试类型:"OS"

#测试平台:[7A,7A_Integrated,7A_2way,780,2K,3A_4000]
#目前支持5个平台
#----------------------------------------------------------------------------------------

sh Make_Result_Ini_OS_7A.sh

sh Make_Result_Ini_OS_7A_Integrated.sh

sh Make_Result_Ini_OS_7A_2way.sh

sh Make_Result_Ini_OS_780.sh

sh Make_Result_Ini_OS_2K.sh

sh Make_Result_Ini_OS_3A_4000.sh
