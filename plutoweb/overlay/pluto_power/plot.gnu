#
# Quick plot level/vs freq
# LamaBleu 06/2018
#
# CSV input file format (space separator) : 
# freq(Hz) level
# comments at the end of file only
#
set terminal svg size 1200, 600
set output '/www/signal.svg'
set title "Fstart : " . sprintf("%09.3f", f0/1000) . " kHz  -  Fstop " . sprintf("%09.3f", fmax/1000) . " kHz"
set xlabel "freq. [MHz]"
#set yrange [90:0]
set ylabel "level [dB]"
set format x "%1.3f"
set timestamp
set key at graph 0.95, 0.95
set size 0.95,0.95
plot '/tmp/test.csv' using ($1)/1000000:($2) with lines lc rgb '#bf000a' title 'pow_pluto-0.29 calculation', \
'/tmp/test.csv' using ($1)/1000000:($2) s b lc rgb '#2e4053' title 'average'
plot '/tmp/test.csv' using ($1)/1000000:($3)*-1 with lines lc rgb '#2e4053' title 'RSSI (IIO data)'
