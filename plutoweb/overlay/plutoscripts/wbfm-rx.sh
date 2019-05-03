echo "Usage : wbfm-rx.sh <Freq-MHz> <gain 0-73>  - example : wbfm-rx.sh 105.1 72"
echo "WBFM stream : http://192.168.2.1:4444 (48000Hz)"
echo "Listen audio stream : nc 192.168.2.1 4444 | mplayer -cache 1024 -quiet -rawaudio samplesize=2:channels=1:rate=48000 -demuxer rawaudio -"
echo "or : nc 192.168.2.1 4444 | aplay -r 96k -f dat -c 1"
rx_sdr -F CF32 -s 3000000 -f ${1}M -g $2 - | csdr fir_decimate_cc 12 0.06 HAMMING | csdr fmdemod_quadri_cf | csdr fractional_decimator_ff 5  | csdr deemphasis_wfm_ff 48000 75e-6 | csdr convert_f_i16 | nmux -a 192.168.2.1 -p 4444

