#!/bin/sh
## Pull in settings
. /bin/readsettings.sh >/dev/null

cd /dump1090
./dump1090 --net --net-http-port 8080 --gain 89 --aggressive
