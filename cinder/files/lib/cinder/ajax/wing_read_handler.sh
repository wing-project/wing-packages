wing_read_handler() {
	cat <<EOF
{
	"command": "$FORM_cmd",
	"s_code": "200",
	"s_desc": "OK",
	"output" : [
EOF
	result=$(printf "read lt.links\nquit\n" | nc 127.0.0.1 7777 | grep -v ^Click::ControlSocket | grep -v ^DATA | grep -v "200 Goodbye!"| grep -v "200 Read handler" | sed 's/^/\"/g' | sed 's/$/\",/g')
	echo $result | sed 's/.$//g'
	cat <<EOF
	]
}
EOF
}

