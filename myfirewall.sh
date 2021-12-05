#!/bin/bash

#Parse Firewall Logs
input="/var/log/firewalld"
while log= read -r line
do
	protocol=""
	dport=""
	sport="" 
	icmptype=""
	icmpcode=""
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
	elif  [[ ${logarray[14]} == TYPE=* ]] ;
	then
		icmptype="${logarray[14]}"
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
	elif  [[ ${logarray[15]} == TYPE=* ]] ;
	then
		icmptype="${logarray[15]}"
	elif  [[ ${logarray[15]} == CODE=* ]] ;
	then
		icmpcode="${logarray[15]}"
	fi
	if  [[ ${logarray[16]} == SPT=* ]] ;
	then
		sport="${logarray[16]}"
	elif  [[ ${logarray[16]} == DPT=* ]] ;
	then
		dport="${logarray[16]}"
	elif  [[ ${logarray[16]} == TYPE=* ]] ;
	then
		icmptype="${logarray[16]}"
	elif  [[ ${logarray[16]} == CODE=* ]] ;
	then
		icmpcode="${logarray[16]}"
	fi
	if  [[ ${logarray[17]} == DPT=* ]] ;
	then
		dport="${logarray[17]}"
	elif  [[ ${logarray[17]} == TYPE=* ]] ;
	then
		icmptype="${logarray[17]}"
	elif  [[ ${logarray[17]} == CODE=* ]] ;
	then
		icmpcode="${logarray[17]}"
	fi
	if [[ $protocol == "PROTO=2" ]] ; then
		protocol="PROTO=IGMP"
	fi
	if [[ $protocol == "PROTO=ICMP" ]] ; then
		echo "${logarray[0]} ${logarray[6]} ${logarray[7]} ${logarray[8]} $protocol $icmptype $icmpcode"
	else
		echo "${logarray[0]} ${logarray[6]} ${logarray[7]} ${logarray[8]} $protocol $sport $dport"
	fi
	#echo "$line"
done < "$input"
