#!/usr/bin/haserl
<%

export CINDER_display="System/Overview"

. /lib/cinder/common.sh
cinder_print_header

%>

<table class="inline" width="60%">
  <tr><td width="30%">Hostname:</td><td width="60%"><% echo $hostname %></td></tr>
  <tr><td>OS Release:</td><td><% echo $os_name%> <% echo $os_release %></td></tr>
  <tr><td>OS Version:</td><td><% echo $os_version %></td></tr>
  <tr><td>Processor:</td><td><% echo $processor %></td></tr>
  <tr><td>Load:</td><td><% echo $load %></td></tr>
  <tr><td>Memory:</td><td><% echo "${ram_used}MiB / ${ram_total}MiB (${ram_perc}%)" %></td></tr>
  <tr><td>Local Time:</td><td><% echo $current_time %></td></tr>
  <tr><td>Uptime:</td><td><% echo $uptime %></td></tr>
  <tr><td>Firmware Version:</td><td><% echo $version %> (<% echo $tag %>_<% echo $subtarget %>)</td></tr>
</table>

<%

cinder_print_footer

%>

