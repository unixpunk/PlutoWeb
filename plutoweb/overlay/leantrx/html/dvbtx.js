// This file is part of LeanTRX (c) <pabr@pabr.org>.
// See the toplevel README for more information.

// Config for DVB modulator.

var config = {
    standard: "DVB-S",
    cr: "1/2",
    cstln: "QPSK",
    symbrate: "20e3",
    interp: 30,
    rrc_rej: "10",

    destination: "leaniiotx",
    devindex: 0,
    bufsize: 65536,
    nbufs: 32,
    freq: "2449e6",    // As string to preserve formatting

    autorun: false,
};

// DVBTX runtime

function make_sdr_url() {
    var params = config_to_cgi();
    return "/cgi-bin/leantrx/dvbtx.cgi?action=run" + params;
}

function process(obj) {
    alert("Unexpected aux output from CGI: "+obj);
}
