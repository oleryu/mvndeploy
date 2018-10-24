#!/bin/bash
#############################################################
#
# @yuhongliang
#
#############################################################

pomxml=$1

pfs_num=`cat $pomxml|sed -n '/profiles/='|sed ':a ; N;s/\n/ / ; t a ; '`
pfs_start=`echo ${pfs_num}|awk '{print $1}'`
pfs_end=`echo ${pfs_num}|awk '{print $2}'`

#echo $pfs_start
#echo $pfs_end

pf_num=`cat $pomxml|sed -n ''"$pfs_start"','"$pfs_end"'p'|sed -n '/^[\t ]*<[/]*profile>$/='|sed ':a ; N;s/\n/ / ; t a ; '`

#pf_arr=($pf_num)

#len=${#pf_arr[@]}

i=0

while [[ -n "$pf_num" ]]
do
    pf_num_start=${pf_num%%" "*}
    pf_num=${pf_num#*" "}
    pf_num_end=${pf_num%%" "*}


    #echo $pf_num_start" -> "$pf_num_end

    let start_num=$pfs_start+$pf_num_start-1
    let end_num=$pfs_start+$pf_num_end-1

    #echo $start_num" -> "$end_num

    cat $pomxml|sed -n ''"$start_num"','"$end_num"'p'|sed 's/[\t ]*\(.*\)[\t ]*/\1/g'|sed ":a;N;s/\n//g;ta"

    if [ "$pf_num" == "$pf_num_end" ]
    then
        break
    else
        pf_num=${pf_num#*" "}
    fi

done