#!/usr/bin/haserl
<%

export CINDER_display="Tools/GPS"

. /lib/cinder/common.sh
cinder_print_redirect $CINDER_restart_service

( /sbin/uci set gpsd.core.enabled=$FORM_enabled
/sbin/uci set gpsd.core.device=$FORM_device
/sbin/uci set gpsd.core.port=$FORM_port
/sbin/uci commit 
/etc/init.d/gpsd restart &) > /dev/null 2>&1 &

%>
