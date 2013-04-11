#!/bin/sh 

config_load gpsd
config_get device core device
config_get port core port
config_get_bool enabled core enabled

[ "$enabled" != "1" ] || {
	config_get time tpv time
	config_get latitude tpv latitude
	config_get longitude tpv longitude
	config_get altitude tpv altitude
	config_get fix tpv fix
}

