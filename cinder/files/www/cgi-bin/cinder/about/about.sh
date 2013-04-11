#!/usr/bin/haserl
<%

export CINDER_display="About/About"

. /lib/cinder/common.sh
cinder_print_header 

%>

<div class="center">
  <p class="heading">CINDER</p>
  <p>Version: <%= $version %></p>
  <p class="heading">Credits</p>
  <p>Roberto Riggio</p>
</div>

<%

cinder_print_footer

%>

