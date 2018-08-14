#!/bin/sh
## Pull in any saved settings or use defaults
. /bin/readsettings.sh >/dev/null

## Start openwebrx
cd /openwebrx
python openwebrx.py
