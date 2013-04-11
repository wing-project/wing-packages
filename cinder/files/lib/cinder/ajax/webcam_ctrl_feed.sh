webcam_ctrl_feed() {

	local result=$(/usr/bin/mjpg-proxy ${GET_address:+-h$GET_address} ${GET_port:+-s$GET_port} ${GET_action:+-a$GET_action} ${GET_dest:+-d$GET_dest} ${GET_plugin:+-p$GET_plugin} ${GET_id:+-i$GET_id} ${GET_group:+-g$GET_group} ${GET_value:+-v$GET_value} 2> /dev/null | grep "^${GET_action}")

	if [ "$?" = "0" ]; then
		local action=$(echo $result | cut -d: -f1)
		local value=$(echo $result | cut -d: -f2)
		cat <<EOF
		{
		     "command": "$FORM_cmd",
		     "s_code": "200",
		     "s_desc": "Success",
		     "action": "$action",
		     "value": "$value",
		}
EOF
	else	
		cat <<EOF
		{
		     "command": "$FORM_cmd",
		     "s_code": "520",
		     "s_desc": "Not-Supported"
		     "action": "${GET_action}",
		}
EOF
	fi


}
