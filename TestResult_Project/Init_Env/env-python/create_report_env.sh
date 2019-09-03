#!/bin/bash


export WORKON_HOME=/home/work/env-wrapper

echo ---------------------------------
echo 'active the virtualenvwrapper'
echo ---------------------------------
source /usr/bin/virtualenvwrapper.sh

echo ---------------------------------
echo 'change to virtualenv:env-report'
echo ---------------------------------
workon env-report

cd /Proj_TestResults/TestResult_Project/TestReport/TestReport_OS_7A
echo "进入工作目录"
pwd

python result.py 
#install mariadb driver
#echo 'installing mariadb driver...'
#pip install MySQL-python

#install packages required for the current project
#pip install -r requirements.txt
