#!/bin/sh 

# param 
topic=OMS_TO_CX_APPOINTMENT 
port=9093


cmd="tcpdump 'tcp dst port $port"

function f_cmd_conn()  
{  
    type_pos=5
    client_id_pos=13
    len_pos=31
    data_pos=32
    header_len="tcp[12]/4"
	client_id_len="tcp[$header_len+$client_id_pos]"
    conn="tcp[$header_len+$type_pos]=1 and tcp[$header_len+$len_pos+$client_id_len]=${#topic}"
    for ((i=0;$i<${#topic};i=$i+1));
    do
        conn=$conn`printf " and tcp[$header_len+$data_pos+$client_id_len]=0x%x" "'${topic:$i}"`
        ((data_pos=$data_pos+1))
    done
    echo $conn
} 

cmd=$cmd" and (`f_cmd_conn 0`)'"
echo $cmd
