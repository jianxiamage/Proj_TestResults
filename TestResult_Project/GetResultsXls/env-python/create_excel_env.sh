#!/bin/bash


export WORKON_HOME=/home/work/env-wrapper

echo ---------------------------------
echo 'active the virtualenvwrapper'
echo ---------------------------------
source /usr/bin/virtualenvwrapper.sh

echo ---------------------------------
echo 'change to virtualenv:env-excel'
echo ---------------------------------
workon env-report

echo "进入工作目录"
pwd
#pip install xlwt
#pip install xlrd
#pip freeze > ./requirements.txt
#cat requirements.txt
pip install -r requirements.txt
#install mariadb driver
#echo 'installing mariadb driver...'
#pip install MySQL-python

#install packages required for the current project
#pip install -r requirements.txt
