// This file is part of LeanTRX (c) <pabr@pabr.org>.
// See the toplevel README for more information.

// Simple audio streaming by HTTP polling.

var audioplayer = new Object();

(function () {

    if ( ! window.AudioContext ) {
	audioplayer.toggle = function () {
	    alert("Your browser does not support audio");
	}
	return;
    }
    
    function Queue() {
	var qin=[], qout=[];
	this.put = function(e) { qin.push(e); }
	this.get = function() {
	    if ( qout.length == 0 ) { qout=qin.reverse(); qin=[]; }
	    return qout.pop();  // undefined if empty
	}
	this.length = function() { return qin.length+qout.length; }
	this.flush = function() { qin=qout=[]; }
    };
    
    var audioqueue = new Queue();
    var chunk_size = 16384;
    var target_latency = 6;
    
    var el_heartbeat = document.getElementById("heartbeat_audio");
    function update_heartbeat(color) {
	el_heartbeat.style.background = color;
    }

    var req;  // Pending XMLHttpRequest, null if shutting down.
    
    function stream_next(position, size) {
	update_heartbeat("#00ff00");
	req = new XMLHttpRequest();
	var args = "bytes=" + position + "-" + (position+size-1);
	req.open("GET", "/cgi-bin/leantrx/getstream.cgi?action=get&"+args);
	req.responseType = "arraybuffer";
	req.onreadystatechange  = function() {
	    if ( req.readyState == 4 ) {
		if ( !req.status || !req.response ) return;  // Disabled
		var delay;
		if ( req.status == 200 ) {
		    update_heartbeat("#008000");
		    if ( audioqueue.length() < target_latency ) {
			audioqueue.put(req.response);
		    } else {
			// Stream is too fast - drop these samples
			console.log("audio drop");
		    }
		    position += size;
		    var f = function() { stream_next(position,size); };
		    setTimeout(f, 0);
		} else {
		    update_heartbeat("#ff0000");
		    setTimeout(stream_first, 500);
		}
	    }
	}
	req.send(null);
    }

    function stream_first() {
	console.log("audio resync");
	update_heartbeat("#808000");
	req = new XMLHttpRequest();
	req.open("GET", "/cgi-bin/leantrx/getstream.cgi?action=sync");
	req.onreadystatechange = function() {
	    if ( req.readyState == 4 ) {
		if ( req.status == 200 ) {
		    update_heartbeat("#008000");
		    var next = parseInt(req.responseText);
		    var f = function() { stream_next(next, chunk_size); };
		    setTimeout(f, 500);
		} else {
		    update_heartbeat("#800000");
		    setTimeout(stream_first, 1000);
		}
	    }
	}
	req.send(null);
    }

    function gentone(freq) {
	var s = new Float32Array(chunk_size);
	var periods = Math.floor(freq*chunk_size/config.Fa);
	for ( var i=0; i<s.length; ++i )
	    s[i] = 20.0 * Math.sin(2*Math.PI*i*periods/chunk_size);
	return s;
    }
    var busytone = gentone(440.0);

    function audioprocess(ev) {
	var outbuf = ev.outputBuffer;
	if ( audioqueue.length() <= 0 ) {
	    // Stream is too slow - insert samples
	    console.log("audio fill");
	    outbuf.copyToChannel(busytone, 0, 0);
	} else {
	    var indata = audioqueue.get();
	    var inview = new Int8Array(indata);
	    var outdata = outbuf.getChannelData(0);
	    // Use built-in convertion from int8 to float,
	    // and scale down to -1..+1 with a gain node.
	    outdata.set(inview);
	}
    }
    
    var ctx;
    
    function ctx_start() {
	ctx = new window.AudioContext();
	var script = ctx.createScriptProcessor(chunk_size, 0, 1);
	script.onaudioprocess = audioprocess;
	var gain = ctx.createGain();
	script.connect(gain);
	gain.gain.value = 1.0 / 128;
	gain.connect(ctx.destination);
    }

    function ctx_stop() {
	ctx.close();
    }
    
    function toggle() {
	if ( req ) {
	    req.abort();
	    update_heartbeat("#c0c0c0");
	    req = null;
	    ctx_stop();
	} else {
	    stream_first();
	    ctx_start();
	}
    }

    audioplayer.toggle = toggle;
}());

if ( config.autorun ) audioplayer.toggle();
