#!/bin/sh 

config_load network

config_get wan_up wan up
config_get wan_ifname wan ifname
config_get wan_proto wan proto
config_get wan_ipaddr wan ipaddr
config_get wan_netmask wan netmask
config_get wan_gateway wan gateway

config_get lan_up lan up
config_get lan_ifname lan ifname
config_get lan_proto lan proto
config_get lan_ipaddr lan ipaddr
config_get lan_netmask lan netmask

config_get mesh_up mesh up
config_get mesh_ifname mesh ifname
config_get mesh_proto mesh proto
config_get mesh_ipaddr mesh ipaddr
config_get mesh_netmask mesh netmask
config_get mesh_profile mesh profile "bulk"
config_get mesh_rc mesh rc "minstrel"
config_get mesh_ls mesh ls "fcfs"
config_get mesh_metric mesh metric "wcett"
config_get_bool mesh_debug mesh debug "false"

rcs=""
for rc in $(find /etc/wing/ -name "rc.*.click" | sort); do 
	stripped=$(basename $rc | sed 's/rc.//g' | sed 's/.click//g')
	rcs="$rcs $stripped"
done

lss=""
for ls in $(find /etc/wing/ -name "ls.*.click" | sort); do 
	stripped=$(basename $ls | sed 's/ls.//g' | sed 's/.click//g')
	lss="$lss $stripped"
done

profiles=""
for profile in $(find /etc/wing/ -name "profile.*.click" | sort); do 
	stripped=$(basename $profile | sed 's/profile.//g' | sed 's/.click//g')
	profiles="$profiles $stripped"
done

metrics="wcett ett etx hopcount"

mesh_gateway=$(read_handler wr/set_gateway.gateway)

rc_selected=$mesh_rc
ls_selected=$mesh_ls
profile_selected=$mesh_profile

