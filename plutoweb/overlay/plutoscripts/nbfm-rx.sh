echo "Usage : nbfm-rx <freq-Hz> <gain:0-73> - example : nbfm-rx.sh 466208000 72 "
echo "NBFM stream : http://192.168.2.1 (48000Hz)"
echo "Listen audio stream : nc 192.168.2.1 4444 | mplayer -cache 1024 -quiet -rawaudio samplesize=2:channels=1:rate=48000 -demuxer rawaudio - "

rx_sdr -F CF32 -s 2400000 -f $1 -g $2 - | csdr fir_decimate_cc 50 0.005 HAMMING | csdr fmdemod_quadri_cf  | csdr limit_ff | csdr deemphasis_nfm_ff 48000 | csdr fastagc_ff | csdr convert_f_i16  | nmux -p 4444 -a 192.168.2.1


