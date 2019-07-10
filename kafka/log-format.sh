#!/bin/sh 

cat /tmp/head10 | while read line
do
#    echo ${line}
    time=`echo ${line} | sed 's/.*\(2019-.\{14\}\).*/\1/'`
#    echo ${time}
    time_second=`date -d "$time" +%s`
#    echo ${time_second}
    new_line=`echo $line | sed 's/.$//'`
#    echo $new_line
    new_line=$new_line" "$time_second
#    echo $new_line
    result=`echo ${new_line} | awk '{printf "log id=%s,url=%s %s", $1,$4,$6}'`
    echo ${result}
done
