#!/bin/sh 

leases=$(cat /var/dhcp.leases | awk '{ printf "<tr><td>%s</td><td>%s</td><td>%s</td>",$2,$3,$4}')
static_leases=$(cat /etc/ethers | awk '{ printf "<tr><td>%s</td><td>%s</td>",$1,$2}')

config_load dhcp

config_get start lan start
config_get limit lan limit
config_get leasetime lan leasetime
config_get_bool ignore lan ignore

