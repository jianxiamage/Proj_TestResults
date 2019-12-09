#!/bin/bash


#function readIni() {
#    file=$1;section=$2;item=$3;
#    val=$(awk -F '=' '/\['${section}'\]/{a=1} (a==1 && "'${item}'"==$1){a=0;print $2}' ${file}) 
#    echo ${val}
#}
 
function readIni() {
 file=$1; section=$2; item=$3
 readIni=`awk -F '=' '/\['$section'\]/{a=1}a==1&&$1~/'$item'/{print $2;exit}' $file`
 echo ${readIni}
}


writeIni() {
    file=$1;section=$2;item=$3;val=$4
	test -f "$1" && test ! -z "$2" && test ! -z "$3" && test ! -z "$4"
	if [ $? -eq 0 ]; then
		awk -F '=' '/\['${section}'\]/{a=1} (a==1 && "'${item}'"==$1){gsub($2,"\"'${val}'\"");a=0} {print $0} {close("'${file}'")}' ${file} 1<>${file}
	fi
} 

function readIniSections() {
    file=$1;
    val=$(awk '/\[/{printf("%s ",$1)}' ${file} | sed 's/\[//g' | sed 's/\]//g')
    echo ${val}
}

