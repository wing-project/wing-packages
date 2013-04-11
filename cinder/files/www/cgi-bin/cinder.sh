#!/usr/bin/haserl
Content-Type: application/json
Cache: none

<%

. /lib/wing/wing-common-extra.sh

include /lib/cinder/ajax/

default() {
	cat <<EOF
	{
	     "command": "$FORM_cmd",
	     "s_code": "200",
	     "s_desc": "Success",
	}
EOF
}

[ "$FORM_cmd" = "" ] && FORM_cmd="default"

type "$FORM_cmd" | grep -q "shell function" && {
	eval "$FORM_cmd"
} || {
	cat <<EOF
	{
	     "command": "$FORM_cmd",
	     "s_code": "520",
	     "s_desc": "Not-Supported"
	}
EOF
}

%>
