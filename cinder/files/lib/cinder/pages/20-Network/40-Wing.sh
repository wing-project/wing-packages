#!/bin/sh 

list_ifaces() {

        local channel hwmode hwaddr ifname mode freq up   

        config_get ifname $1 ifname
        config_get mode $1 mode
        config_get device $1 device
        config_get_bool up $1 up

        [ "$up" = "1" -a "$mode" = "monitor" ] || return 0 

        config_get hwmode $device hwmode "11b" 
        config_get channel $device channel "1" 

        ifaces=${ifaces:+"$ifaces "}"<tr><td>$device</td><td>$ifname</td><td>$hwmode</td><td>$channel</td></tr>" 

}

list_probes() {
	local words=$(read_handler wr/es/es_$1.probes | wc -w)
	local lines=$(read_handler wr/es/es_$1.bcast_stats | wc -l)
	local colums=$(($words/2))
	local groups=$(($lines/$(($colums+1))))
	local probes=""
	for i in `seq 3 2 $(($words))`; do 
		local rate=$(read_handler wr/es/es_$1.probes | cut -d " " -f$i)
		local probes="$probes<td>$(($rate/2))</td>"
	done
	local stats=""
	for i in `seq 1 $groups`; do 
		local lower=$((1+$(($i-1))*$(($colums+1))))
		local upper=$(($i*$(($colums+1))))
		local addr=$(read_handler wr/es/es_$1.bcast_stats | sed -n "${lower}p" | awk '{printf "<td>%s</td>", $1}')
		local fwd=$(read_handler wr/es/es_$1.bcast_stats | sed -n "$(($lower+1)),${upper}p" | awk '{printf "<td>%s</td>", $6}')
		local rev=$(read_handler wr/es/es_$1.bcast_stats | sed -n "$(($lower+1)),${upper}p" | awk '{printf "<td>%s</td>", $7}')
		local row=$(echo "<tr>$addr $fwd $rev</tr>")
		local stats="${stats}${row}"
	done
	eval "colums$1=\$colums"
	eval "probes$1=\$probes"
	eval "stats$1=\$stats"
}

hnas=$(read_handler wr/gw.hnas | sed -n 's/\([0-9\.]*\) \([0-9\.]*\) \([0-9\.]*\)/<tr><td>\1<\/td><td>\2<\/td><\/tr>/p')

static_routes=$(read_handler wr/querier.routes | sed -n 's/\([0-9\.]*\) hops \([0-9]*\) \(.*\)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/p')

gws=$(read_handler wr/gw.gateway_stats | sed -n 's/\([0-9\.]*\) \([0-9\.]*\) \([0-9\.]*\) seen \([0-9]*\) first_update \([0-9\.]*\) last_update \([0-9\.]*\) current_metric \([0-9]*\)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><td>\4<\/td><td>\5<\/td><td>\6<\/td><td>\7<\/td><\/tr>/p')

routes=$(read_handler lt.routes | sed -n 's/\([0-9\.]*\) hops \([0-9]*\) metric \([0-9]*\) \(.*\)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><td>\4<\/td><\/tr>/p')

links=$(read_handler lt.links | awk '{printf "<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>", $1, $2, $3, $4, $5, $6}')

config_load wireless
config_foreach list_ifaces wifi-iface

interfaces=$(read_handler lt.hosts | grep $(read_handler lt.ip) | sed -n "s/.*interfaces: \(.*\)/\1/p")

for interface in $interfaces; do
      list_probes $interface
done

config_load network
config_get up mesh up
config_get ifname mesh ifname

