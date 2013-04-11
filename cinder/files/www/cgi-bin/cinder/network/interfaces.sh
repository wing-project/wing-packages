#!/usr/bin/haserl
<%

export CINDER_display="Network/Interfaces"

. /lib/cinder/common.sh
cinder_print_header

%>

<table class="inline" width="100%">
  <tr><th>Network</th><th>Interface</th><th>Protocol</th><th>MAC Address</th><th>IP Address</th><th>Netmask</th><th>Traffic<div class="footnote">TX/RX</div></th><th>Errors<div class="footnote">TX/RX</div></th></tr>
  <% if [ "$networks" = "" ]; then %>
    <tr><td colspan="8">No networks available</td></tr>
  <% fi %>
  <%= $networks %>
</table>

<%

cinder_print_footer

%>

