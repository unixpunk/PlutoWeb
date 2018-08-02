// This file is part of LeanTRX (c) <pabr@pabr.org>.
// See the toplevel README for more information.

// Generic framwork for simple UI based on polling status information
// in JSON format from leansdrserv over HTTP.

function urlparams_to_config() {
    //    var entries = new URL(location).searchParams.entries();
    //    for ( var p; p=entries.next().value; ) {
    var params = String(document.location).split("?")[1];
    if ( ! params ) return;
    params = params.split("&");
    for ( var i=0; i<params.length; ++i ) {
	var p = params[i].split("=");
	var name = p[0];
	var val = p[1];
	var defval = config[name];
	if ( defval == undefined )
	    alert("Ignoring URL parameter "+name);
	else {
	    if ( typeof defval == "string" )
		config[name] = val;
	    else if ( typeof defval == "number" )
		config[name] = Number(val);
	    else if ( typeof defval == "boolean" )
		config[name] = (val=="on");
	    else
		alert("Bug: Unsupported type for "+name+"="+defval);
	}
    }
}

function config_to_widgets() {
    for ( var name in config ) {
	var el = document.getElementById("config_"+name);
	if ( ! el ) continue;
	var val = config[name];
	if ( typeof val == "boolean" )
	    el.checked = val;
	else
	    el.value = val;
    }
}

function widgets_to_config() {
    for ( var name in config ) {
	var el = document.getElementById("config_"+name);
	if ( ! el ) continue;
	var curval = config[name];
	var newval;
	if      ( typeof curval == "boolean" )
	    newval = el.checked;
	else if ( typeof curval == "number" )
	    newval = Number(el.value);
	else
	    newval = el.value;
	config[name] = newval;
    }
}
 
function config_to_cgi() {
    var params = "";
    for ( var name in config ) {
	var val = config[name];
	if ( typeof val == "boolean" )
	    val = val ? "on" : "off";
	params += "&"+name+"="+val;
    }
    return params;
}

urlparams_to_config();

config_to_widgets();

// Runtime

var sdr = new Object();

(function () {
    var el_heartbeat = document.getElementById("heartbeat_sdr");

    function update_heartbeat(color) {
	el_heartbeat.style.background = color;
    }

    var el_command = document.getElementById("command");
    var el_console = document.getElementById("console");

    var req;

    function start() {
	update_heartbeat("#ffff00");
	var url = make_sdr_url();
	el_command.innerHTML = "Running "+url;
	req = new XMLHttpRequest();
	req.open("GET", url);
	req.onreadystatechange = function() {
	    if ( req.readyState == 3 ) {
		// Some browsers will display partial output
		el_console.innerHTML = req.responseText;
		update_heartbeat("#00ff00");
	    }
	    if ( req.readyState == 4 ) {
		// Don't erase console on abort
		if ( req.responseText )
		    el_console.innerHTML = req.responseText;
		update_heartbeat("#ff0000");
		req = null;
	    }
	}
	req.send(null);
    }

    function toggle() {
	if ( req ) {
	    req.abort();
	    req = null;
	    update_heartbeat("#c0c0c0");
	} else {
	    widgets_to_config();
	    start();
	}
    }

    sdr.toggle = toggle;

}());

var ui = new Object();

(function () {
    
    var el_heartbeat = document.getElementById("heartbeat_ui");

    function update_heartbeat(color) {
	el_heartbeat.style.background = color;
    }

    var req;

    function poll() {
	if ( ! req ) return; 
	update_heartbeat("#ffff00");
	req = new XMLHttpRequest();
	var url = location.protocol+"//"+location.hostname+":8003/";
	req.open("GET", url);
	req.onreadystatechange = function() {
	    if ( ! req ) return;
	    if ( req.readyState != 4 ) return;
	    var delay;
	    if ( req.status == 200 ) {
		update_heartbeat("#00ff00");
		var obj = JSON.parse(req.responseText);
		process(obj);
		delay = 1000 / config.uirate;
	    } else {
		update_heartbeat("#ff0000");
		delay = 1000;
	    }
	    setTimeout(poll, delay);
	}
	req.send(null);
    }
    
    function toggle() {
	if ( req ) {
	    req = null;
	    update_heartbeat("#c0c0c0");
	} else {
	    widgets_to_config();
	    req = true;
	    poll();
	}
    }

    ui.toggle = toggle;
}());

if ( config.autorun ) {
    sdr.toggle();
    ui.toggle();
}
