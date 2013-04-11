#!/usr/bin/haserl
<%

export CINDER_display="Tools/WiFiStumbler"
. /lib/cinder/common.sh
cinder_print_header 

%>

<form action="<%= $CINDER_self %>">

<table class="inline">
  <tr>
    <td>Interface:</td>
    <td>
      <select name="iface">
        <option value="none">None</option>
        <% 
        for iface in $ifaces; do 
          if [ "$iface" = "$ifaces_selected" ]; then
          %>
            <option value="<%= $iface %>" selected="true"><%= $iface %></option>
          <% 
          else
          %>
            <option value="<%= $iface %>"><%= $iface %></option>
          <%
          fi
        done 
        %>
      </select>
      <input type="submit" name="submit" value="Scan">
    </td>
  </tr>
</table>

<% if [ "$FORM_iface" != "" -a "$FORM_iface" != "none" ]; then %>

<p class="heading">Access points per channel</p>

<p class="heading">Available access points</p>

<table class="inline" width="75%">
  <tr>
    <th>&nbsp;</th>
    <th>SSID</th>
    <th>MAC (BSSID)</th>
    <th>Channel</th>
    <th>Signal (dBm)</th>
    <th>Encryption</th>
  </tr>
  <% 
  OIFS=$IFS
  IFS=";"
  count=1
  for entry in $entries; do 
    bssid=$(echo $entry | awk '{print $1}')
    ssid=$(echo $entry | awk '{print $2}' | sed 's/\"//g')  
    frequency=$(echo $entry | awk '{print $3}')
    channel=$(echo $entry | awk '{print $4}')
    snr=$(echo $entry | awk '{print $5}')
    enc=$(echo $entry | awk '{print $6}')
    wpa=$(echo $entry | awk '{print $7}')
    %>
    <tr>
      <td><%= $count %></td>
      <td><%= $ssid %></td>
      <td><%= $bssid %></td>
      <td><%= $channel %> (<%= $frequency %> GHz)</td>
      <td><%= $snr %></td>
      <td>
        <% if [ "$enc" = "on" ]; then %>
          <img src="/imgs/cinder/tools/network-wireless-encrypted.png" alt="<%= $wpa %>" title="<%= $wpa %>" />
        <% else %>
          <img src="/imgs/cinder/tools/network-wireless.png" alt="Not Encrypted" title="Not Encrypted" />
        <% fi %>
      </td>
    </tr>
    <%
    count=$((count+1))
  done 
  IFS=$OIFS
  %>
</table>

<% fi %>

<%

cinder_print_footer

%>

