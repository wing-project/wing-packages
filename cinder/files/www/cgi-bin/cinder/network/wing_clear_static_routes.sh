#!/usr/bin/haserl
<%

export CINDER_display="Network/Wing"

. /lib/cinder/common.sh
cinder_print_redirect $CINDER_restart_service

( clear_static_routes &) > /dev/null 2>&1 &

%>

