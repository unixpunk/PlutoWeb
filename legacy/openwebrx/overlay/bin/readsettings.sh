#!/bin/sh
## Source this file for either default or previous settings

## Use temp settings if they exist instead of pulling from NVRAM
if [ -f /root/temp-settings ]; then
	echo "Temp settings found, using them..."
	. /root/temp-settings
if [ -z ${center_freq} ]; then
        export center_freq=460250000
fi
if [ -z ${start_freq} ]; then
        export start_freq=460102200
fi
if [ -z ${samp_rate} ]; then
        export samp_rate=600000
fi
if [ -z ${start_mod} ]; then
        export start_mod="nfm"
fi
if [ -z ${rf_gain} ]; then
        export rf_gain=89
fi
if [ -z ${ppm} ]; then
        export ppm=0
fi
	echo ""
	echo "Current settings are:"
	echo "Center frequency = $center_freq"
	echo "Starting frequency = $start_freq"
	echo "Sample rate = $samp_rate"
	echo "Starting demodulator = $start_mod"
	echo "RF gain = $rf_gain"
	echo "PPM = $ppm"
	echo ""
else
echo "No temp settings found, pulling from NVRAM and saving to temp file..."
export `fw_printenv center_freq`
if [ -z ${center_freq} ]; then
        export center_freq=460250000
fi
export `fw_printenv start_freq`
if [ -z ${start_freq} ]; then
        export start_freq=460102200
fi
export `fw_printenv samp_rate`
if [ -z ${samp_rate} ]; then
        export samp_rate=600000
fi
if [ -z ${start_mod} ]; then
        export start_mod="nfm"
fi
export `fw_printenv rf_gain`
if [ -z ${rf_gain} ]; then
        export rf_gain=89
fi
export `fw_printenv ppm`
if [ -z ${ppm} ]; then
        export ppm=0
fi
echo "export center_freq=$center_freq" >/root/temp-settings
echo "export start_freq=$start_freq" >>/root/temp-settings
echo "export samp_rate=$samp_rate" >>/root/temp-settings
echo "export start_mod=$start_mod" >>/root/temp-settings
echo "export rf_gain=$rf_gain" >>/root/temp-settings
echo "export ppm=$ppm" >>/root/temp-settings
chmod +x /root/temp-settings
echo ""
echo "Ignore any messages above this line..."
echo ""
echo "Current settings are:"
echo "Center frequency = $center_freq"
echo "Starting frequency = $start_freq"
echo "Sample rate = $samp_rate"
echo "Starting demodulator = $start_mod"
echo "RF gain = $rf_gain"
echo "PPM = $ppm"
echo ""
fi
