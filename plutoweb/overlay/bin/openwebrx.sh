#!/bin/sh
## Pull in any saved settings or use defaults
. /bin/readsettings.sh >/dev/null

## This is a workaround for an issue where SoapySDR remembers its install path
## and tries to use it as its 'root' directory...Fake it.
if [ ! -d "/home/steve/Desktop/SDR/Pluto" ]; then
	mkdir -p /home/steve/Desktop/SDR/Pluto
	ln -s / /home/steve/Desktop/SDR/Pluto/staging
fi

## Start openwebrx
cd /openwebrx
python openwebrx.py
