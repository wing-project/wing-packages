ping_exec() {
	local target=$GET_target
	local count=$GET_count
	local cmd="ping -c $count $target"
	$cmd > /tmp/ping.log && {
		local s_code=200
		local s_desc="Success"
		local output=""
		local rows=0
		while read line; do
		    output="$output $line\n"
		    rows=$((rows+1))
		done < /tmp/ping.log
		rows=$((rows+2))
	} || {
		local s_code=520
		local s_desc="Not-Supported"
	}
	cat <<EOF
	{
	     "command": "$FORM_cmd",
	     "s_code": "$s_code",
	     "s_desc": "$s_desc",
	     "cmd": "$cmd",
	     "output": "$output",
	     "rows": "$rows",
	}
EOF
	
}

