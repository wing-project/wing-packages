#!/bin/sh 

hostname=$(uname -n)
os_release=$(uname -r)
os_name=$(uname -s)
os_version=$(uname -v)
processor=$(uname -a | awk '{print $11}')
load=$(cat /proc/loadavg | awk '{printf "%s %s %s", $1, $2, $3}') 
uptime_sec=$(cat /proc/uptime | awk '{print $1}' | awk -F. '{print $1}') 
secs=$(($uptime_sec%60))
mins=$((${uptime_sec}/60%60))
hours=$((${uptime_sec}/3600%24))
days=$((${uptime_sec}/86400))

if [ "${days}" -ne "0" ]; then
	uptime="${days} days ${hours} hours ${mins} minutes"
else
	uptime="${hours} hours ${mins} minutes"
fi

tag=$(cat /etc/version | awk '{print $1}')
subtarget=$(cat /etc/version | awk '{print $2}')
version=$(cat /etc/version | awk '{print $3}')

current_time=$(date "+%d-%m-%Y %H:%M %Z")

total_mem=$(cat /proc/meminfo | grep "MemTotal:" | awk '{ print $2 }')
free_mem=$(cat /proc/meminfo | grep "MemFree:" | awk '{ print $2 }')
used_mem=$(($total_mem-$free_mem))
ram_used=$((used_mem/1024))
ram_total=$((total_mem/1024))
ram_perc=$(($used_mem * 100 / $total_mem))

