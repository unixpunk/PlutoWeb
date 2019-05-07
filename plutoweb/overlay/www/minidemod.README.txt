minidemod
=========

The purpose of `minidemod-wfm.c` is to have a few lines of code that can actually demodulate WFM from an I/Q input.

The whole DSP chain is built by OS pipes, just like this:

	rtl_sdr -s 240000 -f 89500000 -g 20 - | tcc -lm -run minidemod-wfm.c \
		| sox -t raw -r 240000 -e unsigned -b 8 -c 1 - -t raw - rate 48000 \
		| mplayer -quiet -rawaudio samplesize=1:channels=1:rate=48000 -demuxer rawaudio -

Read like this:

	rtl_sdr (acquires samples) | minidemod-wfm (demodulates) \
		| sox (low pass filter + decimation) | mplayer (audio output) `

To run it, you will need a Linux box with `rtl_sdr tcc sox mplayer` installed.

I've also added `minidemod-wfm-atan.c` with a detailed explanation of the demodulation process. It does sound better, but uses more CPU (still not more than 10% on my box).

## Follow-up

At SDRA-2018 I gave a talk on writing a simple AM/FM/SSB receiver in C:

https://www.youtube.com/watch?v=-QERqK1XAy0

The code (which actually fits on 2 sheets of A4 paper) can be found here:

https://github.com/ha7ilm/smallrx

If you need a fully fledged command-line DSP tool for SDR, see my CSDR project here:

https://github.com/simonyiszk/csdr

## How this tool can be used as a demo on SDR

I used this tool to introduce some fellow students to SDR, after a short explanation on SDR and modulations in general. 

I showed them the code, but previously deleted the formula that does the actual calculation, turning this into a fun exercise: they had to figure out that one line themselves.

If they entered the correct formula, the success was immediate: audio was playing through the speakers. 

Authors
-------

András Retzler <ha7ilm@sdr.hu>

Also tnx [dnet](https://github.com/dnet) for the small fixes.
