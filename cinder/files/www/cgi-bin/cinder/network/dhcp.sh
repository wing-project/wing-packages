#!/usr/bin/haserl
<%

export CINDER_display="Network/DHCP"

. /lib/cinder/common.sh
cinder_print_header

%>

<p class="heading">DHCP Server</p>

<form action="<%= $CINDER_save_config_path %>">

<table class="inline" width="60%">
  <tr>
    <td width="40%">Enabled:</td>
    <td width="60%">
      <select name="ignore">
        <% if [ "$ignore" = "1" ]; then %>
          <option value="false">True</option>
          <option value="true" selected="true">False</option>
        <% else %>
          <option value="false" selected="true">True</option>
          <option value="true">False</option>
        <% fi %>
      </select>
    </td>
  </tr>
  <tr><td>First leased address:</td><td><%= $start %></td></tr>
  <tr><td>Number of leased addresses:</td><td><%= $limit %></td></tr>
  <tr><td>Lease time:</td><td><%= $leasetime %></td></tr>
  <tr><td colspan="2" align="right"><input type="submit" name="submit" value="Apply"></td></tr>
</table>

</form>

<p class="heading">Leases</p>

<table class="inline">
  <tr><th>MAC Address</th><th>IP Address</th><th>Host Name</th></tr>
  <% if [ "$leases" = "" ]; then %>
    <tr><td colspan="3">No leases available</td></tr>
  <% fi %>
  <%= $leases %>
</table>

<p class="heading">Static Leases</p>

<table class="inline">
  <tr><th>MAC Address</th><th>IP Address</th></tr>
  <% if [ "$static_leases" = "" ]; then %>
    <tr><td colspan="2">No static leases defined</td></tr>
  <% fi %>
  <%= $static_leases %>
</table>

<%

cinder_print_footer

%>

