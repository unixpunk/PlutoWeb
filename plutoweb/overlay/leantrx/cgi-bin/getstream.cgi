#!/bin/sh

# This file is part of LeanTRX (c) <pabr@pabr.org>.
# See the toplevel README for more information.

# Usage: getstream.cgi?bytes=FIRST-LAST

FILE=/tmp/stream

available=$(ls -l $FILE  2> /dev/null | awk '{print $5}')

if [ "$QUERY_STRING" = "action=sync" ]; then
    [ -n "$available" ]  ||  available=0
       cat <<EOF
Content-Type: text/plain; charset=utf-8

$available
EOF
fi    

first=$(expr "$QUERY_STRING" : '.*bytes=\([0-9]*\)-[0-9]*.*')
last=$(expr "$QUERY_STRING" : '.*bytes=[0-9]*-\([0-9]*\).*')

if [ -z "$first" -o -z "$last" -o $last -lt $first ]; then
  exit 1
fi

next=$((last+1))
length=$((next-first))

force_resync() {
    cat <<EOF
Status: 404 Requested range is out of bounds. Please resync.

EOF
    exit
}

retries=10
while [ -z "$available" -o $next -gt "$available" ]; do
  echo "Waiting for $first-$last in $FILE, currently at $available..."  1>&2
  sleep 0.2
  available=$(ls -l $FILE  2> /dev/null  |  awk '{print $5}')
  if [ -n "$available" -a $((first-1)) -gt "$available" ]; then
      echo "Stream file has shrunk. Resyncing."  1>&2
      force_resync
  fi
  retries=$((retries-1))
  if [ $retries = 0 ]; then
      echo "Stream file is stalled. Resyncing."  1>&2
      force_resync
  fi
done

cat <<EOF
Content-Type: application/binary

EOF

# Optimize when $length is a multiple of 16^n
bs=1
while [ $((first&15)) = 0 -a $((length&15)) = 0 ]; do
    first=$((first/16))
    length=$((length/16))
    bs=$((bs*16))
done
dd if=$FILE bs=$bs skip=$first count=$length  2> /dev/null
