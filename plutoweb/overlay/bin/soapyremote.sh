#!/bin/sh
## Pull in settings
. /bin/readsettings.sh >/dev/null

cd
while [[ "$autostart" = "SoapyRemote" ]]; do
/bin/SoapySDRServer --bind
sleep 1
. /bin/readsettings.sh >/dev/null
done
