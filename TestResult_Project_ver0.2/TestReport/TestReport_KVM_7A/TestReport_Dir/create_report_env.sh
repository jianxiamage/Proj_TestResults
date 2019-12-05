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

echo "Begin to create test report..."
python result.py 

python result_simple.py 

