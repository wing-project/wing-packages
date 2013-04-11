#!/usr/bin/haserl
<%

export CINDER_display="Network/Network"

. /lib/cinder/common.sh
cinder_print_header 

%>

<p class="heading">Internet/WAN</p>

<% if [ "$wan_up" = "1" ]; then %>

<form action="<%= ${CINDER_zone_path}/${CINDER_referer}_save_wan_config.sh %>">

<table class="inline" width="50%">
  <tr><td width="40%">Interface:</td><td width="60%"><%= $wan_ifname %></td></tr>
  <tr><td>Protocol:</td><td><%= $wan_proto %></td></tr>
  <tr><td>Address:</td><td><%= $wan_ipaddr %></td></tr>
  <tr><td>Netmask:</td><td><%= $wan_netmask %></td></tr>
  <tr><td>Default Gateway:</td><td><%= $wan_gateway %></td></tr>
  <tr><td colspan="2" align="right"><input type="submit" name="submit" value="Apply"></td></tr>
</table>

</form>

<% else %>

<p>Interface down</p>

<% fi %>

<p class="heading">Backhaul/Mesh</p>

<% if [ "$mesh_up" = "1" ]; then %>

<form action="<%= ${CINDER_zone_path}/${CINDER_referer}_save_mesh_config.sh %>">

<table class="inline" width="50%">
  <tr><td width="40%">Interface:</td><td width="60%"><%= $mesh_ifname %></td></tr>
  <tr><td>Protocol:</td><td><%= $mesh_proto %></td></tr>
  <tr><td>Address:</td><td><%= $mesh_ipaddr %></td></tr>
  <tr><td>Netmask:</td><td><%= $mesh_netmask %></td></tr>
  <tr><td>Default Gateway:</td><td><%= $mesh_gateway %></td></tr>
  <tr>
    <td>Profile:</td>
    <td>
      <select name="profile">
        <% 
        for profile in $profiles; do 
          if [ "$profile" = "$profile_selected" ]; then
          %>
            <option value="<%= $profile %>" selected="true"><%= $profile %></option>
          <% 
          else
          %>
            <option value="<%= $profile %>"><%= $profile %></option>
          <%
          fi
        done 
        %>
      </select>
    </td>
  </tr>
  <tr>
    <td>Rate Control:</td>
    <td>
      <select name="rc">
        <% 
        for rc in $rcs; do 
          if [ "$rc" = "$rc_selected" ]; then
          %>
            <option value="<%= $rc %>" selected="true"><%= $rc %></option>
          <% 
          else
          %>
            <option value="<%= $rc %>"><%= $rc %></option>
          <%
          fi
        done 
        %>
      </select>
    </td>
  </tr>
  <tr>
    <td>Link scheduler:</td>
    <td>
      <select name="ls">
        <% 
        for ls in $lss; do 
          if [ "$ls" = "$ls_selected" ]; then
          %>
            <option value="<%= $ls %>" selected="true"><%= $ls %></option>
          <% 
          else
          %>
            <option value="<%= $ls %>"><%= $ls %></option>
          <%
          fi
        done 
        %>
      </select>
    </td>
  </tr>
  <tr>
    <td>Routing metric:</td>
    <td>
      <select name="metric">
        <% 
        for metric in $metrics; do 
          if [ "$metric" = "$metric_selected" ]; then
          %>
            <option value="<%= $metric %>" selected="true"><%= $metric %></option>
          <% 
          else
          %>
            <option value="<%= $metric %>"><%= $metric %></option>
          <%
          fi
        done 
        %>
      </select>
    </td>
  </tr>
  <tr>
    <td>Debug:</td>
    <td>
      <select name="debug">
        <% if [ "$mesh_debug" = "1" ]; then %>
          <option value="true" selected="true">True</option>
          <option value="false">False</option>
        <% else %>
          <option value="true">True</option>
          <option value="false" selected="true">False</option>
        <% fi %>
      </select>
    </td>
  </tr>
  <tr><td colspan="2" align="right"><input type="submit" name="submit" value="Apply"></td></tr>
</table>

</form>

<% else %>

<p>Interface down</p>

<% fi %>

<p class="heading">Local Network/LAN</p>

<% if [ "$lan_up" = "1" ]; then %>

<form action="<%= ${CINDER_zone_path}/${CINDER_referer}_save_lan_config.sh %>">

<table class="inline" width="50%">
  <tr><td width="40%">Interface:</td><td width="60%"><%= $lan_ifname %></td></tr>
  <tr><td>Protocol:</td><td><%= $lan_proto %></td></tr>
  <tr><td>Address:</td><td><%= $lan_ipaddr %></td></tr>
  <tr><td>Netmask:</td><td><%= $lan_netmask %></td></tr>
  <tr><td colspan="2" align="right"><input type="submit" name="submit" value="Apply"></td></tr>
</table>

</form>

<% else %>

<p>Interface down</p>

<% fi %>


<%

cinder_print_footer

%>

