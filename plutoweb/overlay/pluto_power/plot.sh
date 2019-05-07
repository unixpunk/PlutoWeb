#!/bin/sh

# Will display a plot from example.csv file
# and save the plot as example-1.png
# CSVfile : freq(Hz) level(dB) 

fstart=$(tail -1 /tmp/test.csv | awk '{print $1}')
fend=$(head -1 /tmp/test.csv | awk '{print $1}')
echo "Starting graph build..."
gnuplot -persist -e "fmax=$fstart;f0=$fend" /pluto_power/plot.gnu
. /bin/readsettings.sh >/dev/null
echo "Graph available at http://$hostname/signal.png or http://$ip/signal.png"
