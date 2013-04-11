#!/usr/bin/haserl
<%

export CINDER_display="Tools/Ping"

. /lib/cinder/common.sh
cinder_print_header

%>

<script language="javascript">

function JCinderPrintPing(doc) {
  var jsonData = eval("(" + doc + ")")
  if (jsonData.s_code == "200") {
      document.getElementById('output').innerHTML = "<p class=\"heading\">Results of \"" + jsonData.cmd + "\" </p><textarea rows=\"" + jsonData.rows + "\" cols=\"80\">" + jsonData.output + "</textarea>"
  } else {
    document.getElementById('output').innerHTML = "<p class=\"heading\">Service not available</p>";
  }
}

function ping() {
  var target = document.getElementById('target').value
  document.getElementById('output').innerHTML = "<p class=\"heading\">Pinging " + target + "...</p>"
  JCinderGet('ping_exec&target='+target+"&count=5", JCinderPrintPing)
}

</script>

<form action="">
  <table class="inline" width="60%">
    <tr><td>Target:</td><td><input type="text" id="target" value="www.google.com" /></td></tr>
    <tr><td colspan="2" align="right"><input type="submit" value="Ping" onclick="ping(); return false;" /></td></tr>
  </table>
</form>

<br />

<div id="output">
</div>

<%

cinder_print_footer

%>
