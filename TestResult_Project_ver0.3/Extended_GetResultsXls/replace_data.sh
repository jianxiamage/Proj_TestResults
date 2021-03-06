#!/bin/sh

#同时在多个文件中的相同代码,可以采用统一做法,便于修改
#例如多个文件中使用的路径,可以事先存在文件中,这样当目录发生修改时,
#只需要修改一个文件即可

oldstr="/data/"
newstr="/data/"

#sed -i  "s#${oldstr}#${str}#g" $(find -type f -name "*.py")


grep -rl --exclude="$0" $oldstr ./ |xargs sed -i "s#$oldstr#$newstr#g"

