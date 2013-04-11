webcam_list_feeds() {
	local port result response
	local hosts=$(read_handler lt.routes | awk '{print $1}' | sort | uniq)
	config_load mjpg-streamer
	config_get port core port
	for host in $hosts; do
		response=""
		response=$(printf "GET /program.json\n\n" | nc $host $port 2>/dev/null | grep "HTTP/1.0 200 OK")
		[ "$response" != "" ] && result="${result} [ \"$host\", \"$port\" ] , "
	done
	sleep 2
	cat <<EOF
	{
	     "command": "$FORM_cmd",
	     "s_code": "200",
	     "s_desc": "Success",
	     "hosts": [ $result ],
	}
EOF
	
}
