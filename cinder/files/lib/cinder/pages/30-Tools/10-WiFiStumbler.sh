#!/bin/sh 

list_ifaces() {
        local ifname mode up   
        config_get ifname $1 ifname
        config_get mode $1 mode
        config_get_bool up $1 up
        [ "$up" = "0" -o "$mode" = "monitor" -o "$mode" = "ap" ] && return 0 
	ifaces="$ifaces $ifname"
}

scan_network() {
	list=$(iwlist $1 scan | sed 1d | sed 's/Cell/#/g')
	blocks=$(echo $list | tr -dc '#' | wc -c)
	entries=""
	for i in $(seq 2 1 $((blocks+1))); do
		chunk=$(echo $list | cut -d# -f$i)
		row=$(echo $chunk | sed -n 's/.*Address: \([0-9A-Z:]*\) ESSID:\(.*\) Mode.*Frequency:\([0-9\.]*\) GHz (Channel \([0-9]*\)).*Signal level=\([0-9\-]*\).*dBm.*Encryption key:\([a-z]*\).*/\1 \2 \3 \4 \5 \6 \7/p')
		wpa=$(echo $chunk | sed -n 's/.*IE.*\(WPA[2]\{0,1\}\).*/\1/p')
		entries="${entries}${row} ${wpa};"
	done
}

[ "$FORM_iface" != "" ] && {
	scan_network $FORM_iface
	ifaces_selected=$FORM_iface
} 

config_load wireless
config_foreach list_ifaces wifi-iface 

