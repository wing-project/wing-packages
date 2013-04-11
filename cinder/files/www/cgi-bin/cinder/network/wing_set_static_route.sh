#!/usr/bin/haserl
<%

export CINDER_display="Network/Wing"

. /lib/cinder/common.sh
cinder_print_redirect $CINDER_restart_service

( add_static_route "$FORM_route" &) > /dev/null 2>&1 &

%>

