#!/bin/sh
## Pull in any saved settings or use defaults
. /bin/readsettings.sh >/dev/null

## Check and apply override pre-set
if [ $openwebrx_override == 1 ]; then
	export max_clients=15
	export fft_voverlap_factor=0
	export samp_rate=100000
	echo "Using Max Concurrent Users - Low Quality Pre-Set"
elif [ $openwebrx_override == 2 ]; then
	export max_clients=7
	export fft_voverlap_factor=0.3
	export samp_rate=250000
	echo "Using Max Concurrent Users - High Quality Pre-Set"
elif [ $openwebrx_override == 3 ]; then
	export samp_rate=1500000
	export fft_voverlap_factor=0
	export max_clients=1
	echo "Using Max Sample Rate - Low Quality Pre-Set"
elif [ $openwebrx_override == 4 ]; then
	export samp_rate=1500000
	export fft_voverlap_factor=0.3
	export max_clients=1
	echo "Using Max Sample Rate - High Quality Pre-Set"
fi

## Start openwebrx
cd /openwebrx
python openwebrx.py
