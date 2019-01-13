#!/bin/sh
## Pull in any saved settings or use defaults
. /bin/readsettings.sh >/dev/null

## Check and apply override pre-set
if [ $openwebrx_override == 1 ]; then
	export max_clients=15
	export samp_rate=100000
	echo "Using Pre-Set 100ksps = 15 users max"
elif [ $openwebrx_override == 2 ]; then
	export max_clients=7
	export samp_rate=300000
	echo "Using Pre-Set 300ksps = 7 users max"
elif [ $openwebrx_override == 3 ]; then
	export samp_rate=900000
	export max_clients=2
	echo "Using Pre-Set 900ksps = 2 users max"
elif [ $openwebrx_override == 4 ]; then
	export samp_rate=1500000
	export max_clients=1
	echo "Using Pre-Set 1.5msps = 1 user max"
fi

## Start openwebrx
cd /openwebrx
python openwebrx.py
