#!/bin/sh
## Pull in settings
. /bin/readsettings.sh >/dev/null

## Run dump1090 with the best options available in this fork
cd /dump1090
while [[ "$autostart" = "dump1090" ]]; do
./dump1090 --net --net-http-port 8080 --gain 89 --aggressive
sleep 1
. /bin/readsettings.sh >/dev/null
done
