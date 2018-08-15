#!/bin/sh

# This file is part of LeanTRX (c) <pabr@pabr.org>.
# See the toplevel README for more information.

. ./cgiutils.sh

cat <<EOF
Content-Type: text/plain; charset=utf-8

EOF

exec 2>&1

param_standard=DVB-S
param_cr=1/2
param_cstln=QPSK
param_symbrate=2000e3
param_interp=30
param_rrc_rej=0

param_dest=leaniiotx
param_devindex=0
param_freq=2449e6
param_bufsize=$((1024*1024))
param_nbufs=32


parse_query_string

killprocs

samprate=$(dc $param_symbrate $param_interp mul p)
	      
command="leantsgen  |  leandvbtx --cr $param_cr --const $param_cstln -f $param_interp --s16 --power 0 --rrc-rej $param_rrc_rej -v |  leaniiotx  --bufsize $param_bufsize  --nbufs $param_nbufs  -f $param_freq  -s $samprate  --bw $param_symbrate -v"

echo $command
eval $command
