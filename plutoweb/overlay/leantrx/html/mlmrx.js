// This file is part of LeanTRX (c) <pabr@pabr.org>.
// See the toplevel README for more information.

// Config for multi-channel legacy mode receiver.

var config = {
    source: "leaniiorx",
    devindex: 0,
    Fc: "98e6",    // As string to preserve formatting
    bw: "20e6",
    Fs: "25.6e6",
    bufsize: 1048576,
    nbufs: 32,
    fftsize: 64,
    maxdev: "75e3",
    squelch: 0,
    Fa: 0,
    channels: "90.0,92.0,94.0,96.0,98.0,100.0,102.0,104.0,106.0",
    uirate: 1,
    autorun: false,
};

if ( config.Fa == 0 ) {
    if ( window.AudioContext ) {
	console.log("Reading AudioContext rate...");
	config.Fa = (new AudioContext()).sampleRate;
	var e = document.getElementById("audiorate_info");
	if ( e ) e.innerHTML = "(autodetected from browser)";
    } else {
	config.Fa = 44100;
    }
}

// MLMRX runtime

function make_sdr_url() {
    update_mlmrx_ui(config);
    var params = config_to_cgi();
    return "/cgi-bin/leantrx/mlmrx.cgi?action=run" + params;
}

// Initialized by update_mlmrx_ui 
var param_Fc = 98e6;
var param_bw = 20e6;
var param_Fs = 25.6e6;

var c_spectrum = document.getElementById("spectrum");
var ctx_spectrum = c_spectrum.getContext("2d");

var c_waterfall = document.getElementById("waterfall");
var ctx_waterfall = c_waterfall.getContext("2d");
ctx_waterfall.fillStyle = '#00FF00';  //TBD
var wfline = ctx_waterfall.createImageData(1, c_waterfall.height);
for ( var i=0; i<wfline.height; ++i ) wfline.data[i*4+3] = 255;

function toggle_channel(event) {
    var action = event.target.checked ? "UNMUTE" : "MUTE";
    var chan = event.target.id;
    var args = "action="+action+"&chan="+chan;
    var baseurl = location.protocol+"//"+location.hostname+":8004";
    var req = new XMLHttpRequest();
    req.open("GET", baseurl+"/"+action+"="+chan);
    req.onreadystatechange = function() {
	if ( req.readyState == 4 ) {
	    console.log("toggle "+args+ "result="+req.status);
	    if ( req.status != 200 )
		event.target.parentNode.style.color = "red";
	}
    }
    req.send(null);
    // Visually indicate that the request is being processed.
    event.target.parentNode.style.color = "yellow";
    event.target.mlmrx_toggle_in_progress = true;
}

function make_station(id, freqMHz) {
    var span = document.createElement("span");
    var fnorm = 0.5 + (Number(freqMHz)*1e6-param_Fc)/param_bw;
    var y = Math.floor(c_spectrum.height * fnorm);
    span.setAttribute("class", "mlmstation");
    span.setAttribute("style", "position:absolute;left:0;top:"+y+";");
    span.innerHTML = '<input id="'+id+'" type="checkbox" onclick="toggle_channel(event)">'+freqMHz;
    return span;
}

var el_stations = document.getElementById("stations");

var cur_channels = [];

function update_channels(channels) {
    if ( channels.length != cur_channels.length ) {
	console.log("Redrawing all stations");
	while ( el_stations.childNodes.length > 0 ) {
	    el_stations.removeChild(el_stations.childNodes[0]);
	}
	for ( var i=0; i<channels.length; ++i ) {
	    var span = make_station(i, channels[i].freq);
	    el_stations.appendChild(span);
	    var el = document.getElementById(String(i));
	    el.checked = channels[i].enabled;
	}
	cur_channels = channels;
    } else {
	for ( var i=0; i<channels.length; ++i ) {
	    if ( channels[i].freq != cur_channels[i].freq ) {
		console.log("Moving station "+i);
		var cur_span = el_stations.childNodes[i];
		var span = make_station(i, channels[i].freq);
		el_stations.replaceChild(span, cur_span);
	    }
	    var el = document.getElementById(String(i));
	    if ( el.checked != channels[i].enabled ) {
		if ( el.mlmrx_toggle_in_progress ) {
		    // Ignore first status report after a toggle
		} else {
		    console.log("Updating station "+i+":"+channels[i].enabled);
		    el.checked = channels[i].enabled;
		}
	    } else {
		if ( el.mlmrx_toggle_in_progress ) {
		    el.mlmrx_toggle_in_progress = false;
		    el.parentNode.style.color = "white";
		}
	    }
	}
	cur_channels = channels;
    }
}

var el_fmin = document.getElementById("freq_min");
var el_fmax = document.getElementById("freq_max");

function update_mlmrx_ui() {
    param_Fc = Number(config.Fc);
    param_bw = Number(config.bw);
    param_Fs = Number(config.Fs);

    el_fmin.innerHTML = (Math.round((param_Fc-param_bw/2)/1e3)/1e3)+" MHz";
    el_fmax.innerHTML = (Math.round((param_Fc+param_bw/2)/1e3)/1e3)+" MHz";
}

//////////////////////////////////////////////////////////////////////


// Float
db0 = -70;
dbrange = 50;
// Pluto
db0 = -30;
dbrange = 80;
// Pluto test
db0 = 60;
dbrange = 50;

function update_spectrum(spectrum) {
    var w=c_spectrum.width, h=c_spectrum.height;
    ctx_spectrum.clearRect(0,0, w,h);
    ctx_spectrum.strokeStyle = '#008000';
    for ( var db=10; db<dbrange; db+=10 ) {
	var x = w - db*w/dbrange;
	ctx_spectrum.beginPath();
	ctx_spectrum.moveTo(x, 0);
	ctx_spectrum.lineTo(x, h-1);
	ctx_spectrum.stroke();
    }
    ctx_spectrum.strokeStyle = '#FFFFFF';
    ctx_spectrum.beginPath();
    for ( var i=0; i<h; ++i ) {
	var f = spectrum.length * (0.5+(i-h/2)/h*param_bw/param_Fs);
	var db = spectrum[Math.floor(f)];
	var x = (db-db0)*w/dbrange;
	if ( i == 0 ) ctx_spectrum.moveTo(x, i);
	else          ctx_spectrum.lineTo(x, i);
    }
    ctx_spectrum.stroke();
}

var colorscale = new Array(1024);
for ( var i=0; i<256; ++i ) {
    colorscale[i*4+0] = i;
    colorscale[i*4+1] = 255-1.9*Math.abs(i-128);
    colorscale[i*4+2] = 255-i;
    colorscale[i*4+3] = 255;
}


function update_waterfall(spectrum) {
    var w=c_waterfall.width, h=c_waterfall.height;
    // Shift left one column
    var old = ctx_waterfall.getImageData(1,0, w-1,h);
    ctx_waterfall.putImageData(old, 0,0);
    // Fill rightmost line
    for ( var i=0; i<h; ++i ) {
	var f = spectrum.length * (0.5+(i-h/2)/h*param_bw/param_Fs);
	var db = spectrum[Math.floor(f)];
	var level = (db-db0) * 256 / dbrange;
	level = Math.floor(level);  // trunc is less supported
	if ( level < 0 )   level = 0;
	if ( level > 255 ) level = 255;
	wfline.data[i*4+0] = colorscale[level*4+0];
	wfline.data[i*4+1] = colorscale[level*4+1];
	wfline.data[i*4+2] = colorscale[level*4+2];
	wfline.data[i*4+3] = colorscale[level*4+3];
    }
    ctx_waterfall.putImageData(wfline, w-1,0);
}

function update_generic(f, val) {
    if ( val && val.length>=1 ) f(val[0]);
}

function process(obj) {
    update_generic(update_channels, obj.CHANNELS);
    update_generic(update_spectrum, obj.SPECTRUM);
    update_generic(update_waterfall, obj.SPECTRUM);
}
