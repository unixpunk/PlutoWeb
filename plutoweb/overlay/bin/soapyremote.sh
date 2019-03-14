#!/bin/sh
## Pull in settings
. /bin/readsettings.sh >/dev/null

cd
/bin/SoapySDRServer --bind
