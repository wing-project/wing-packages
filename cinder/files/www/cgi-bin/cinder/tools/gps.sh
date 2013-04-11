#!/usr/bin/haserl
<%

export CINDER_display="Tools/GPS"

. /lib/cinder/common.sh
cinder_print_header

%>

<p class="heading">Configuration</p>

<form action="<%= $CINDER_save_config_path %>">

<table class="inline" width="60%">
  <tr>
    <td width="30%">Enabled:</td>
    <td width="70%">
      <select name="enabled">
        <% if [ $enabled -eq 1 ]; then %>
          <option value="true" selected="true">True</option>
          <option value="false">False</option>
        <% else %>
          <option value="true">True</option>
          <option value="false" selected="true">False</option>
        <% fi %>
      </select>
    </td>
  </tr>
  <tr><td>Device:</td><td><input type="text" name="device" value="<%= $device %>"/></td></tr>
  <tr><td>Port:</td><td><input type="text" name="port" value="<%= $port %>"/></td></tr>
  <tr><td colspan="2" align="right"><input type="submit" value="Apply"></td></tr>
</table>

</form>

<% if [ $enabled != 0 ]; then %>

<p class="heading">Status</p>

<table class="inline" width="60%">
  <tr><td width="30%">Time:</td><td id="time" width="70%"><% echo $time %></td></tr>
  <tr><td>Latitude:</td><td id="latitude"><% echo $latitude %></td></tr>
  <tr><td>Longitude:</td><td id="longitude"><% echo $longitude %></td></tr>
  <tr><td>Altitude:</td><td id="altitude"><% echo $altitude %></td></tr>
  <tr><td>Fix:</td><td id="fix"><% echo $fix %></td></tr>
</table>

<% fi %>

<%

cinder_print_footer

%>

