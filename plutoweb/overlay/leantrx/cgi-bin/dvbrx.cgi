#!/bin/sh

# This file is part of LeanTRX (c) <pabr@pabr.org>.
# See the toplevel README for more information.

. ./cgiutils.sh

cat <<EOF
Content-Type: text/plain; charset=utf-8

EOF

exec 2>&1

param_standard=DVB-S
param_symbrate=2000e3
param_cstln=QPSK
param_cr=1/2

param_source=leaniiorx
param_devindex=0
param_freq=2449e6
param_samprate=4e6
param_bufsize=$((1024*1024))
param_nbufs=32

param_tune=0
param_sampler=nearest
param_rrc_rej=10
param_viterbi=off
param_fastlock=off
param_drift=off
param_satmodem=off

param_udp=0
param_udpaddr=0
param_udpport=0
param_rtp=0
param_rtpaddr=0
param_rtpport=0
param_httpd=0
param_httpdport=81
param_file_output=0

parse_query_string

killprocs

if [ "$param_file_output" = on ]; then
    FILE_OUTPUT="| tee $RECORDINGS/$(date +%Y%m%d-%H%M%S%z).ts"
fi

command="leaniiorx  --bufsize $param_bufsize  --nbufs $param_nbufs  -f $param_freq  -s $param_samprate  --bw $param_symbrate  -v  \
| leansdrserv  --info3-httpd 8003  \
  leandvb --s16 -f $param_samprate --tune $param_tune --sr $param_symbrate  --sampler $param_sampler  --rrc-rej $param_rrc_rej  --const $param_cstln  --standard $param_standard  --cr $param_cr  $(flagparam $param_viterbi --viterbi)  $(flagparam $param_fastlock --fastlock)  -v --json  --anf 0  --fd-info 3  --fd-const 3  --fd-spectrum 3 $FILE_OUTPUT > /dev/null"

echo $command
eval $command
