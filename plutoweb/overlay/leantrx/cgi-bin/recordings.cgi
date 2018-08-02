#!/bin/sh

# This file is part of LeanTRX (c) <pabr@pabr.org>.
# See the toplevel README for more information.

. ./cgiutils.sh

cd $RECORDINGS  ||  exit 1

cat <<EOF
Content-Type: text/html; charset=utf-8

<body>
Current time: $(date +%Y%m%d-%H%M%S%z)
<pre><ul>
EOF


for f in *; do
    cat <<EOF
<li><a href="/leantrx/recordings/$f">$(ls -eh $f)</a>
EOF
done

cat <<EOF
</pre></ul></body>
EOF
