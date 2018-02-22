#!/bin/sh

## Run dump1090 with the best options available in this fork
cd /dump1090
./dump1090 --net --net-http-port 8080 --gain 89 --aggressive
