sh myfirewall.sh | awk -F " " '{print$2" "$3" "$4" "$5" "$6" "$7}' | sort -u
