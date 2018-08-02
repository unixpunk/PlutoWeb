#!/bin/sh

# This file is part of LeanTRX (c) <pabr@pabr.org>.
# See the toplevel README for more information.

. ./cgiutils.sh

cat <<EOF
Content-Type: text/plain; charset=utf-8

EOF

exec 2>&1

param_Fc=98e6
param_Fs=25.6e6
param_bw=20e6
param_bufsize=$((1024*1024*4))
param_nbufs=4
param_fftsize=64
param_maxdev=75e3
param_Fa=44100
param_squelch=0
param_channels=
param_uirate=1

parse_query_string

echo "channels=$param_channels"

FREQS=$(echo $param_channels | tr ',' ' ')

killprocs
rm -f /tmp/stream

cmd1="nice -n -5  leaniiorx -v -f $param_Fc -s $param_Fs --bw $param_bw  \
   	    --bufsize $param_bufsize  --nbufs $param_nbufs"
cmd2="nice -n -5  leansdrserv  --info3-httpd 8003  --control4-httpd 8004  -v  \
	   leanmlmrx  --fc $param_Fc  --fs $param_Fs \
	   -N $param_fftsize  --maxdev $param_maxdev  \
           --fa $param_Fa  --squelch $param_squelch  \
	   --fd-info 3  --info-rate $param_uirate  --fd-control 4  \
	   $FREQS"

echo "$cmd1  |  $cmd2  2>&1 > /tmp/stream"  1>&2

$cmd1  |  $cmd2  2>&1 > /tmp/stream
