#!/bin/sh 

. /lib/wing/wing-common-extra.sh

if [ "$CINDER_display" == "" ]; then
	echo "Cinder: variable not set (display)"
	exit 1
fi

config_load network
config_get ipaddr mesh ipaddr

config_load cinder
config_get theme core theme
config_get prefix core prefix

export CINDER_restart_service="5"
export CINDER_restart_network="15"
export CINDER_restart_system="60"
export CINDER_prefix=$prefix
export CINDER_theme=$theme
export CINDER_section=$(echo $CINDER_display | cut -d "/" -f1)
export CINDER_page=$(echo $CINDER_display | cut -d "/" -f2)
export CINDER_section_path=$(basename /lib/cinder/pages/*-$CINDER_section)
export CINDER_page_path=$(basename /lib/cinder/pages/*-$CINDER_section/*-$CINDER_page)
export CINDER_nb_pages=$(ls /lib/cinder/pages/*-$CINDER_section | wc -l)
export CINDER_nodeid=$ipaddr

# Some shortcuts
export CINDER_root_path="/cgi-bin/${CINDER_prefix}"
export CINDER_zone=$(echo "$CINDER_section" | awk '{print tolower($1)}')
export CINDER_zone_path="${CINDER_root_path}/${CINDER_zone}"            
export CINDER_referer=$(echo "$CINDER_page" | awk '{print tolower($1)}')
export CINDER_referer_path="${CINDER_zone_path}/${CINDER_referer}.sh"   
export CINDER_imgs_path="/imgs/${CINDER_prefix}/${CINDER_zone}"      
export CINDER_save_config_path="${CINDER_zone_path}/${CINDER_referer}_save_config.sh"

cinder_iface_tx_errors() {                             
        [ "$1" != "" -a -d "/sys/class/net/$1/" ] && {            
                local stats=$(cat /sys/class/net/$1/statistics/tx_errors)
                case "$2" in                                                
                        "") eval "echo \"\$stats\"";;                       
                        *) eval "export ${NO_EXPORT:+-n} -- \"$2=\$stats\"";    
                esac                                                    
        }                                             
}  

cinder_iface_rx_errors() {                             
        [ "$1" != "" -a -d "/sys/class/net/$1/" ] && {            
                local stats=$(cat /sys/class/net/$1/statistics/rx_errors)
                case "$2" in                                                
                        "") eval "echo \"\$stats\"";;                       
                        *) eval "export ${NO_EXPORT:+-n} -- \"$2=\$stats\"";    
                esac                                                    
        }                                             
}  

cinder_iface_tx_bytes() {                             
        [ "$1" != "" -a -d "/sys/class/net/$1/" ] && {            
                local stats bytes                                 
                stats=$(cat /sys/class/net/$1/statistics/tx_bytes)
                if [ $stats -gt 1048576 ]; then       
                        bytes=$(($stats/1048576))" MiB"
                elif [ $stats -gt 1024 ]; then     
                        bytes=$(($stats/1024))" KiB"
                else                                 
                        bytes=$stats" B"                                     
                fi                                                          
                case "$2" in                                                
                        "") eval "echo \"\$bytes\"";;                       
                        *) eval "export ${NO_EXPORT:+-n} -- \"$2=\$bytes\"";    
                esac                                                    
        }                                             
}    

cinder_iface_rx_bytes() {                             
        [ "$1" != "" -a -d "/sys/class/net/$1/" ] && {            
                local stats bytes                                 
                stats=$(cat /sys/class/net/$1/statistics/rx_bytes)
                if [ $stats -gt 1048576 ]; then       
                        bytes=$(($stats/1048576))" MiB"
                elif [ $stats -gt 1024 ]; then     
                        bytes=$(($stats/1024))" KiB"
                else                                 
                        bytes=$stats" B"                                     
                fi                                                          
                case "$2" in                                                
                        "") eval "echo \"\$bytes\"";;                       
                        *) eval "export ${NO_EXPORT:+-n} -- \"$2=\$bytes\"";    
                esac                                                    
        }                                             
}    

cinder_print_redirect() {
	if [ "$1" != "" ]; then
		export CINDER_refresh=$1
	else
		export CINDER_refresh="5"
	fi
	/usr/bin/haserl "/lib/cinder/$CINDER_theme/redirect.tpl"
}

cinder_print_header() {
	. /lib/cinder/pages/$CINDER_section_path/$CINDER_page_path.sh
	/usr/bin/haserl "/lib/cinder/$CINDER_theme/header.tpl"
}

cinder_print_footer() {
	/usr/bin/haserl "/lib/cinder/$CINDER_theme/footer.tpl"
}

cinder_print_menu() {
	local items items section default url
	items=$(ls /lib/cinder/pages 2>/dev/null)
	for item in $items ; do
		section=$(echo "$item" | sed 's/[0-9]*\-//')
		default=$(ls /lib/cinder/pages/$item/ | sed 's/[0-9]*\-//' | sed 1q)
		url=$(echo "$section/$default" | awk '{print tolower($1)}')
		if [ "$section" == "$CINDER_section" ]; then 
			echo "<li class=\"selected\"><a href=\"$CINDER_root_path/$url\"><span>$section</span></a></li>"
		else
			echo "<li><a href=\"/cgi-bin/cinder/$url\"><span>$section</span></a></li>"
		fi
	done
}

cinder_print_submenu() {
	local items items url
	items=$(ls /lib/cinder/pages/*-$CINDER_section 2>/dev/null)
	for item in $items ; do
		page=$(echo "$item" | sed 's/[0-9]*\-//' | sed 's/.sh$//')
		url=$(echo "$item" | sed 's/[0-9]*\-//' | awk '{print tolower($1)}')
		echo "<a href=\"$url\">$page</a>"
	done
}

