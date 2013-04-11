#!/usr/bin/haserl
<%

export CINDER_display="Network/Network"

. /lib/cinder/common.sh
cinder_print_redirect $CINDER_restart_service

( /sbin/uci set network.mesh.profile="$FORM_profile"
/sbin/uci set network.mesh.rc="$FORM_rc"
/sbin/uci set network.mesh.ls="$FORM_ls"
/sbin/uci set network.mesh.debug="$FORM_debug"
/sbin/uci set network.mesh.metric="$FORM_metric"
/sbin/uci commit 
ifdown mesh && ifup mesh ) > /dev/null 2>&1 &

%>

