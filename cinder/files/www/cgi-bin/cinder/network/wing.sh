#!/usr/bin/haserl
<%

export CINDER_display="Network/Wing"

. /lib/cinder/common.sh
cinder_print_header

%>

<% if [ "$up" = "1" ]; then %>

<p class="heading">Host-Network Associations</p> 

<table class="inline">
  <tr><th>Destination</th><th>Netmask</th></tr>
  <% if [ "$hnas" = "" ]; then %>
    <tr><td colspan="2">No HNA defined</td></tr>
  <% fi %>
  <%= $hnas %>
</table>

<p class="heading">Static Routes</p> 

<form action="<%= ${CINDER_zone_path}/${CINDER_referer}_set_static_route.sh %>">

<table class="inline">
  <tr><th>Destination</th><th>Hops</th><th>Route</th></tr>
  <% if [ "$static_routes" = "" ]; then %>
    <tr><td colspan="3">No routes available</td></tr>
  <% fi %>
  <%= $static_routes %>
  <tr>
    <td colspan="3">New route: <input type="text" size="40" name="route" />&nbsp;<input type="submit" name="submit" value="Add"></td>
  </tr>
</table>

<% if [ "$static_routes" != "" ]; then %>
  <p><a href="<%= ${CINDER_zone_path}/${CINDER_referer}_clear_static_routes.sh %>">Clear static routes</a></p>
<% fi %>

</form>

<p class="heading">Interfaces</p>

<table class="inline">
  <tr><th>Phy</th><th>Device</th><th>Mode</th><th>Channel</th></tr>
  <% if [ "$ifaces" = "" ]; then %>
    <tr><td colspan="4">No interfaces defined</td></tr>
  <% fi %>
  <%= $ifaces %>
</table>

<p class="heading">Gateways</p>

<table class="inline">
  <tr><th>Destination</th><th>Netmask</th><th>Gateway</th><th>Seen</th><th>First Update (secs)</th><th>Last Update (secs)</th><th>Metric</th></tr>
  <% if [ "$gws" = "" ]; then %>
    <tr><td colspan="7">No gateways available</td></tr>
  <% fi %>
  <%= $gws %>
</table>

<p class="heading">Known Routes</p> 

<table class="inline">
  <tr><th>Destination</th><th>Hops</th><th>Metric</th><th>Route (metrics in parentheses)</th></tr>
  <% if [ "$routes" = "" ]; then %>
    <tr><td colspan="4">No routes available</td></tr>
  <% fi %>
  <%= $routes %>
</table>

<p class="heading">Links</p> 

<table class="inline">
  <tr><th>Source</th><th>Destination</th><th>Metric</th><th>Channel</th><th>Sequence</th><th>Age</th></tr>
  <% if [ "$links" = "" ]; then %>
    <tr><td colspan="6">No links available</td></tr>
  <% fi %>
  <%= $links %>
</table>

<%

interfaces=$(read_handler lt.hosts | grep $(read_handler lt.ip) | sed -n "s/.*interfaces: \(.*\)/\1/p")

for interface in $interfaces; do
	%>
	<p class="heading">Broadcast statistics (<%= $interface %>)</p>
	<table class="inline">
	  <tr><th rowspan="2">Neighbor</th><th colspan="<% eval echo \$colums$interface %>">Forward</th><th colspan="<% eval echo \$colums$interface %>">Reverse</th></tr>
	  <tr><td>ACK</td><% eval "echo \$probes$interface" %><td>ACK</td><% eval "echo \$probes$interface" %></tr>
	  <% eval "echo \$stats$interface" %>
	</table>
	<%
done

%>

<% fi %>

<p class="heading">Configuration</p>

<textarea id="code" rows="20" cols="120">
  <% cat "/tmp/$ifname.click" %>
</textarea>

<p class="heading">Logs</p>

<textarea id="code" rows="20" cols="120">
  <% cat "/var/log/$ifname.log" %>
</textarea>

<%

cinder_print_footer

%>

