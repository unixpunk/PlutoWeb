#!/bin/sh

## This is a workaround for an issue where SoapySDR remembers its install path
## and tries to use it as its 'root' directory...lame.  Fake it.
mkdir -p /home/steve/Desktop/SDR/Pluto
ln -s / /home/steve/Desktop/SDR/Pluto/staging

## Start openwebrx
cd /openwebrx
python openwebrx.py
