var xmlHttp;
var jCinderResponseHandler;

function JCinderStateCallback() {
	var stat, rstate;
	if (!xmlHttp) return;
	try {
		rstate = xmlHttp.readyState;
	} catch (err) {
		alert(err);
	}
	switch (rstate) {
		// uninitialized
		case 0:
		// loading
		case 1:
		// loaded
		case 2:
		// interactive
		case 3:
		break;
		// complete, so act on response
		case 4:
		// check http status
		try {
			stat = xmlHttp.status;
		} catch (err) {
			stat = "xmlHttp.status does not exist";
		}
		if (stat == 200) {
			jCinderResponseHandler(xmlHttp.responseText);
		}
	}
}

function JCinderInit() {
	var newXmlHttp;
	try {
		if( window.ActiveXObject ) {
			// Internet Explorer
			for( var i = 5; i; i-- ) {
				try {
					// loading of a newer version of msxml dll (msxml3 - msxml5) failed
					// use fallback solution
					// old style msxml version independent, deprecated
					if( i == 2 ) {
						newXmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
					} else {
						newXmlHttp = new ActiveXObject("Msxml2.XMLHTTP." + i + ".0");        
					}
					break;
				} catch (excNotLoadable) {
					newXmlHttp = false;
				}
			}
		} else if( window.XMLHttpRequest ) {
			// Mozilla, Opera und Safari
			newXmlHttp = new XMLHttpRequest();
		}
	} catch (excNotLoadable) {
		newXmlHttp = false;
	}
	newXmlHttp.onreadystatechange = JCinderStateCallback;
	xmlHttp = newXmlHttp;
}

function JCinderGet(cmd, handler) {
	if (xmlHttp) {
		xmlHttp.abort();
		xmlHttp = false;
	}
	JCinderInit();
	jCinderResponseHandler=handler;
	xmlHttp.open("GET", '/cgi-bin/cinder.sh?cmd='+cmd, true);
	xmlHttp.send(null);
}

