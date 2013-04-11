#!/bin/sh 

append_networks() {

	local ifname proto ipaddr netmask hwaddr traffix_tx traffix rx errors_tx erros_rx up

	config_get ifname $1 ifname
	config_get proto $1 proto
	config_get ipaddr $1 ipaddr
	config_get netmask $1 netmask
	config_get_bool up $1 up

	[ "$up" == "" -o "$up" == "0" ] && return 0

	dev_hwaddr $ifname hwaddr

	traffix_tx=""
	traffix_rx=""

	cinder_iface_tx_bytes $ifname traffix_tx
	cinder_iface_rx_bytes $ifname traffix_rx

	errors_tx=""
	errors_rx=""

	cinder_iface_tx_errors $ifname errors_tx
	cinder_iface_rx_errors $ifname errors_rx

	ifname=${ifname:-"n/a"}
	proto=${proto:-"n/a"}
	ipaddr=${ipaddr:-"n/a"}
	netmask=${netmask:-"n/a"}
	hwaddr=${hwaddr:-"n/a"}
	traffix_tx=${traffix_tx:-"n/a"}
	traffix_rx=${traffix_rx:-"n/a"}
	errors_tx=${errors_tx:-"n/a"}
	errors_rx=${errors_rx:-"n/a"}

	networks=${networks:+"$networks "}"<tr><td>$1</td><td>$ifname</td><td>$proto</td><td>$hwaddr</td><td>$ipaddr</td><td>$netmask</td><td>$traffix_tx / $traffix_rx</td><td>$errors_tx / $errors_rx</td></tr>"

	return 0

}

append_wing() {

	local ifname proto ipaddr netmask hwaddr traffix_tx traffix rx errors_tx erros_rx

	config_load wing
	config_get ifname core ifname 
	config_get proto core proto "static"
	config_get ipaddr core ipaddr
	config_get netmask core netmask

	dev_exists $ifname || return 1

	dev_hwaddr $ifname hwaddr

	traffix_tx=""
	traffix_rx=""

	cinder_iface_tx_bytes $ifname traffix_tx
	cinder_iface_rx_bytes $ifname traffix_rx

	errors_tx=""
	errors_rx=""

	cinder_iface_tx_errors $ifname errors_tx
	cinder_iface_rx_errors $ifname errors_rx

	ifname=${ifname:-"n/a"}
	proto=${proto:-"n/a"}
	ipaddr=${ipaddr:-"n/a"}
	netmask=${netmask:-"n/a"}
	hwaddr=${hwaddr:-"n/a"}
	traffix_tx=${traffix_tx:-"n/a"}
	traffix_rx=${traffix_rx:-"n/a"}
	errors_tx=${errors_tx:-"n/a"}
	errors_rx=${errors_rx:-"n/a"}

	networks=${networks:+"$networks "}"<tr><td>mesh</td><td>$ifname</td><td>$proto</td><td>$hwaddr</td><td>$ipaddr</td><td>$netmask</td><td>$traffix_tx / $traffix_rx</td><td>$errors_tx / $errors_rx</td></tr>"

	return 0

}

networks=""

config_load network
config_foreach append_networks interface

append_wing 

