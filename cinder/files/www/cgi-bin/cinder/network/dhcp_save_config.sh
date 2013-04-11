#!/usr/bin/haserl
<%

export CINDER_display="Network/DHCP"

. /lib/cinder/common.sh
cinder_print_redirect $CINDER_restart_service

( /sbin/uci set dhcp.lan.ignore="$FORM_ignore"
/sbin/uci commit 
/etc/init.d/dnsmasq restart 
/etc/init.d/chilli restart &) > /dev/null 2>&1 &

%>

