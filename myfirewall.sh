#!/bin/bash

#Parse Firewall Logs
input="/var/log/firewalld"
while log= read -r line
do
	protocol=""
	dport=""
	sport="" 
	logarray=($line)
	#echo "${logarray[19]}"
	if  [[ ${logarray[13]} == PROTO=* ]] ;
	then
		protocol="${logarray[13]}"
	fi
	if  [[ ${logarray[14]} == PROTO=* ]] ;
	then
		protocol="${logarray[14]}"
	elif  [[ ${logarray[14]} == SPT=* ]] ;
	then
		sport="${logarray[14]}"
	fi
	if  [[ ${logarray[15]} == PROTO=* ]] ;
	then
		protocol="${logarray[15]}"
	elif  [[ ${logarray[15]} == SPT=* ]] ;
	then
		sport="${logarray[15]}"
	elif  [[ ${logarray[15]} == DPT=* ]] ;
	then
		dport="${logarray[15]}"
	fi
	if  [[ ${logarray[16]} == SPT=* ]] ;
	then
		sport="${logarray[16]}"
	elif  [[ ${logarray[16]} == DPT=* ]] ;
	then
		dport="${logarray[16]}"
	fi
	if  [[ ${logarray[17]} == DPT=* ]] ;
	then
		dport="${logarray[17]}"
	fi
	if [[ $protocol == "PROTO=2" ]] ; then
		protocol="PROTO=IGMP"
	fi
	echo "${logarray[0]} ${logarray[6]} ${logarray[7]} ${logarray[8]} $protocol $sport $dport"
	#echo "$line"
done < "$input"
