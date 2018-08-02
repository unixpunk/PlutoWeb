// This file is part of LeanTRX (C) <pabr@pabr.org>.
// See the toplevel README for more information.

// Config for DVB demodulator.

var config = {
    source: "leaniiorx",
    devindex: 0,
    freq: "2449e6",    // As string to preserve formatting
    samprate: "2.5e6",
    bufsize: 65536,
    nbufs: 32,
    tune: "0",
    symbrate: "2e6",
    sampler: "linear",
    rrc_rej: "10",
    cstln: "QPSK",
    standard: "DVB-S",
    cr: "1/2",
    viterbi: false,
    fastlock: false,
    drift: false,
    uirate: 1,
    autorun: false,
    file_output: false,
};

// DVBRX runtime

function make_sdr_url() {
    var params = config_to_cgi();
    return "/cgi-bin/leantrx/dvbrx.cgi?action=run" + params;
}

c_symbols = document.getElementById("symbols");
ctx_symbols = c_symbols.getContext("2d");
ctx_symbols.strokeStyle = '#FFFFFF';
ctx_symbols.fillStyle = '#00FF00';

c_spectrum = document.getElementById("spectrum");
ctx_spectrum = c_spectrum.getContext("2d");

c_waterfall = document.getElementById("waterfall");
ctx_waterfall = c_waterfall.getContext("2d");
ctx_waterfall.fillStyle = '#00FF00';  //TBD
var wfline = ctx_waterfall.createImageData(c_waterfall.width, 1);
for ( var i=0; i<wfline.width; ++i ) wfline.data[i*4+3] = 255;

c_lock = document.getElementById("lock");
c_offset = document.getElementById("offset");
c_mer = document.getElementById("mer");
c_cnr = document.getElementById("cnr");
c_vber = document.getElementById("vber");
c_standard = document.getElementById("standard");
c_constellation = document.getElementById("constellation");
c_cr = document.getElementById("cr");
c_sr = document.getElementById("sr");

function update_symbols(symbols) {
    var w=c_symbols.width, h=c_symbols.height;
    ctx_symbols.clearRect(0,0, w,h);
    ctx_symbols.strokeRect(w/2,0, 1,h);
    ctx_symbols.strokeRect(0,h/2, w,1);
    var hscale=w/256, vscale=h/256;
    symbols.forEach(function(s) {
	ctx_symbols.fillRect((128+s[0])*hscale,(128-s[1])*vscale,2,2);
    });
}

// Float
db0 = -70;
dbrange = 50;
//Pluto
db0 = -30;
dbrange = 80;

function update_spectrum(spectrum) {
    var w=c_spectrum.width, h=c_spectrum.height;
    ctx_spectrum.clearRect(0,0, w,h);
    ctx_spectrum.strokeStyle = '#008000';
    ctx_spectrum.beginPath();
    ctx_spectrum.moveTo(w/2, 0);
    ctx_spectrum.lineTo(w/2, h-1);
    ctx_spectrum.stroke();
    for ( var db=10; db<dbrange; db+=10 ) {
	var y = h - db*h/dbrange;
	ctx_spectrum.beginPath();
	ctx_spectrum.moveTo(0, y);
	ctx_spectrum.lineTo(w-1, y);
	ctx_spectrum.stroke();
    }
    ctx_spectrum.strokeStyle = '#FFFFFF';
    ctx_spectrum.beginPath();
    for ( var i=0; i<w; ++i ) {
	var f = i * spectrum.length / w;
	var db = spectrum[f];
	var y = h - (db-db0)*h/dbrange;
	if ( i == 0 ) ctx_spectrum.moveTo(i, y);
	else          ctx_spectrum.lineTo(i, y);
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
    // Shift down one line
    var old = ctx_waterfall.getImageData(0,0, w,h-1);
    ctx_waterfall.putImageData(old, 0,1);
    // Fill top line
    for ( var i=0; i<w; ++i ) {
	var f = i * spectrum.length / w;
	var db = spectrum[f];
	var level = (db-db0) * 256 / dbrange;
	level = Math.floor(level);  // trunc is not portable
	if ( level < 0 )   level = 0;
	if ( level > 255 ) level = 255;
	wfline.data[i*4+0] = colorscale[level*4+0];
	wfline.data[i*4+1] = colorscale[level*4+1];
	wfline.data[i*4+2] = colorscale[level*4+2];
	wfline.data[i*4+3] = colorscale[level*4+3];
    }
    ctx_waterfall.putImageData(wfline, 0,0);
}

function update_lock(val) {
    c_lock.innerHTML = val ? "LOCKED" : "SEARCHING";
}
function update_sr(val) {
    c_sr.innerHTML = val / 1000;
}

function update_generic(f, val) {
    if ( val && val.length>=1 ) f(val[0]);
}

function update_simple(span, val) {
    if ( val && val.length>=1 ) span.innerHTML = val[0];
}

function process(obj) {
    update_generic(update_symbols, obj.SYMBOLS);
    update_generic(update_spectrum, obj.SPECTRUM);
    update_generic(update_waterfall, obj.SPECTRUM);
    update_generic(update_lock, obj.LOCK);
    update_simple(c_offset, obj.FREQ);
    update_simple(c_mer, obj.MER);
    update_simple(c_cnr, obj.CNR);
    update_simple(c_vber, obj.VBER);
    update_simple(c_standard, obj.STANDARD);
    update_simple(c_constellation, obj.CONSTELLATION);
    update_simple(c_cr, obj.CR);
    update_generic(update_sr, obj.SR);
}
