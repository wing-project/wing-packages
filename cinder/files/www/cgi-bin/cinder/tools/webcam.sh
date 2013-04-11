#!/usr/bin/haserl
<%

export CINDER_display="Tools/Webcam"

. /lib/cinder/common.sh
cinder_print_header

%>

<script language="javascript">

webcamAddress=""
webcamPort=""

brightness=128
contrast=32
saturation=32

function decSaturation() {
  if ((saturation - 1) > 0) {
    return saturation-= 1;
  }
  return saturation = 0; 
}

function incSaturation() {
  if ((saturation + 1) <= 255) {
    return saturation+= 1;
  }
  return saturation = 255; 
}

function decContrast() {
  if ((contrast - 1) > 0) {
    return contrast-= 1;
  }
  return contrast = 0; 
}

function incContrast() {
  if ((contrast + 1) <= 255) {
    return contrast+= 1;
  }
  return contrast = 255; 
}

function decBrightness() {
  if ((brightness - 10) > 0) {
    return brightness-= 10;
  }
  return brightness = 0; 
}

function incBrightness() {
  if ((brightness + 10) <= 255) {
    return brightness+= 10;
  }
  return brightness = 255; 
}

function JCinderWebcam(doc) {
  var jsonData = eval("(" + doc + ")")
}

function JCinderWebcamResetBrightness() {
  JCinderWebcamCmd('&dest=0&plugin=0&id=9963776&group=1&value=128');
  brightness=128
}

function JCinderWebcamResetContrast() {
  JCinderWebcamCmd('&dest=0&plugin=0&id=9963777&group=1&value=32');
  contrast=32
}

function JCinderWebcamResetSaturation() {
  JCinderWebcamCmd('&dest=0&plugin=0&id=9963778&group=1&value=32');
  saturation=32
}

function JCinderWebcamCmd(cmd) {
  if (webcamAddress == "" || webcamPort == "") {
    alert("Select a feed first!");
  } else {
    JCinderGet('webcam_ctrl_feed&address=' + webcamAddress + '&port=' + webcamPort +'&action=command' + cmd, JCinderWebcam)
  }
}

function JCinderListWebcams(doc) {
  var jsonData = eval("(" + doc + ")")
  var hosts = jsonData.hosts
  if (jsonData.s_code == "200") {
    if (hosts.length > 0) {
      document.getElementById('feeds').innerHTML = ""
      for (i=0;i<hosts.length;i++) {
        document.getElementById('feeds').innerHTML += "<a onClick=\"SetWebCam('"+hosts[i][0]+"','"+hosts[i][1]+"')\" href=\"#\"><img src=\"<%= $CINDER_imgs_path %>/camera-video.png\" alt=\"Feed\" /></a>&nbsp;" + hosts[i][0] + ":" + hosts[i][1] + "<br />";
      }
    } else {
      document.getElementById('feeds').innerHTML = "<p>No feeds available</p>"
    }
  } 
}

function SetWebCam(host, port) {
  webcamAddress = host
  webcamPort = port
  document.getElementById('feed').innerHTML = "<embed width=\"640\" height=\"480\" loop=\"no\" type=\"application/x-vlc-plugin\" autoplay=\"yes\" target=\"http://" + webcamAddress + ":" + webcamPort + "/?action=stream\" />"
  document.getElementById('feed').innerHTML += "<p>URL: http://" + webcamAddress + ":" + webcamPort + "/?action=stream</p>"
}

JCinderGet('webcam_list_feeds', JCinderListWebcams)

</script>

<form id="command_panel" action="" onsubmit="return false;">

  <table width="100%" border="0">
    <tr>
      <td width="80%">
        <div id="feed" class="center">
          <p>No feed selected</p>
        </div>
      </td>
      <td width="20%">
        <table width="100%" border="0">
          <tr><th>Available feeds</th></tr>
          <tr><td id="feeds" align="center"><p>Loading feeds...</p></td></tr>
        </table>
        <br />
        <table width="100%" border="0">
          <tr><th colspan="3">Colors</th></tr>
          <tr>
            <td><div class="center"><input id="brightness_minus" type="image" src="<%= $CINDER_imgs_path %>/list-remove.png" onClick="JCinderWebcamCmd('&dest=0&plugin=0&id=9963776&group=1&value='+decBrightness())"></div></td>
            <td><div class="center">Brightness</div></td>
            <td><div class="center"><input id="brightness_plus" type="image" src="<%= $CINDER_imgs_path %>/list-add.png" onClick="JCinderWebcamCmd('&dest=0&plugin=0&id=9963776&group=1&value='+incBrightness())"></div></td>
          </tr>
          <tr>
            <td colspan="3"><div class="center"><input id="reset" type="button" onClick="JCinderWebcamResetBrightness()" value="Reset" /></div></td>
          </tr>
          <tr>
            <td><div class="center"><input id="contrast_minus" type="image" src="<%= $CINDER_imgs_path %>/list-remove.png" onClick="JCinderWebcamCmd('&dest=0&plugin=0&id=9963777&group=1&value='+decContrast())"></div></td>
            <td><div class="center">Contrast</div></td>
            <td><div class="center"><input id="contrast_plus" type="image" src="<%= $CINDER_imgs_path %>/list-add.png" onClick="JCinderWebcamCmd('&dest=0&plugin=0&id=9963777&group=1&value='+incContrast())"></div></td>
          </tr>
          <tr>
            <td colspan="3"><div class="center"><input id="reset" type="button" onClick="JCinderWebcamResetContrast()" value="Reset" /></div></td>
          </tr>
          <tr>
            <td><div class="center"><input id="saturation_minus" type="image" src="<%= $CINDER_imgs_path %>/list-remove.png" onClick="JCinderWebcamCmd('&dest=0&plugin=0&id=9963778&group=1&value='+decSaturation())"></div></td>
            <td><div class="center">Saturation</div></td>
            <td><div class="center"><input id="saturation_plus" type="image" src="<%= $CINDER_imgs_path %>/list-add.png" onClick="JCinderWebcamCmd('&dest=0&plugin=0&id=9963778&group=1&value='+incSaturation())"></div></td>
          </tr>
          <tr>
            <td colspan="3"><div class="center"><input id="reset" type="button" onClick="JCinderWebcamResetSaturation()" value="Reset" /></div></td>
          </tr>
        </table>
        <br />
        <table width="100%" border="0">
          <tr><th>Pan &amp; tilt</th></tr>
          <tr>
            <td>
              <div class="center">
                <input id="tilt_up_full" type="image" src="<%= $CINDER_imgs_path %>/go-top.png" onClick="JCinderWebcamCmd('&dest=0&plugin=0&id=10094853&group=1&value=-3840')">
              </div>
            </td>
          </tr>
          <tr>
            <td>
              <div class="center">
                <input id="tilt_up" type="image" src="<%= $CINDER_imgs_path %>/go-up.png" onClick="JCinderWebcamCmd('&dest=0&plugin=0&id=10094853&group=1&value=-192')">
              </div>
            </td>
          </tr>
          <tr>
            <td>
              <div class="center">
                <input id="pan_left_full" type="image" src="<%= $CINDER_imgs_path %>/go-first.png" onClick="JCinderWebcamCmd('&dest=0&plugin=0&id=10094852&group=1&value=4480')">&nbsp;
<input id="pan_left" type="image" src="<%= $CINDER_imgs_path %>/go-previous.png" onClick="JCinderWebcamCmd('&dest=0&plugin=0&id=10094852&group=1&value=448')">&nbsp;
<input id="reset_pan_tilt" type="image" src="<%= $CINDER_imgs_path %>/go-home.png" onClick="JCinderWebcamCmd('&dest=0&plugin=0&id=168062211&group=1&value=3')">&nbsp;
<input id="pan_right" type="image" src="<%= $CINDER_imgs_path %>/go-next.png" onClick="JCinderWebcamCmd('&dest=0&plugin=0&id=10094852&group=1&value=-448')">&nbsp;
<input id="pan_right_full" type="image" src="<%= $CINDER_imgs_path %>/go-last.png" onClick="JCinderWebcamCmd('&dest=0&plugin=0&id=10094852&group=1&value=-4480')"><div class="center">
              </div>
            </td>
          </tr>
          <tr>
            <td>
              <div class="center">
                <input id="tilt_down" type="image" src="<%= $CINDER_imgs_path %>/go-down.png" onClick="JCinderWebcamCmd('&dest=0&plugin=0&id=10094853&group=1&value=192')">
              </div>
            </td>
          </tr>
          <tr>
            <td>
              <div class="center">
                <input id="tilt_down_full" type="image" src="<%= $CINDER_imgs_path %>/go-bottom.png" onClick="JCinderWebcamCmd('&dest=0&plugin=0&id=10094853&group=1&value=3840')">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>

</form>

<%

cinder_print_footer

%>

