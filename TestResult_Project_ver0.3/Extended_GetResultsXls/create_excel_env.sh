#!/bin/bash


export WORKON_HOME=/home/work/env-wrapper

echo ---------------------------------
echo 'active the virtualenvwrapper'
echo ---------------------------------
source /usr/bin/virtualenvwrapper.sh

echo ---------------------------------
echo 'change to virtualenv:env-report'
echo ---------------------------------
workon env-excel

echo "Begin to create test result by excel file..."


