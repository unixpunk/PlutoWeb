#!/bin/sh

# This file is part of LeanTRX (c) <pabr@pabr.org>.
# See the toplevel README for more information.

. ./cgiutils.sh

cat <<EOF
Content-Type: text/plain; charset=utf-8

EOF

exec  2>&1

echo "leantrx version $(cat ../html/version.txt)"

for cmd in leandvb leandvbtx leanmlmrx leaniiotx leaniiorx; do
    echo "$cmd version: $($cmd --version)"
done
    
