#!/bin/sh
## This is a workaround for an issue where SoapySDR remembers its install path
## and tries to use it as its 'root' directory...Fake it.
if [ ! -d "/home/steve/Desktop/SDR/Pluto" ]; then
        mkdir -p /home/steve/Desktop/SDR/Pluto
        ln -s / /home/steve/Desktop/SDR/Pluto/staging
fi

## Start SoapySDRServer
cd
/bin/SoapySDRServer --bind
