#!/bin/sh
## Source this file for either default or previous settings
# Set defaults if no previous settings found
autostart_def=openwebrx
center_freq_def=460250000
start_freq_def=460102200
samp_rate_def=600000
start_mod_def=nfm
rf_gain_def=89
ppm_def=0

## Use temp settings if they exist instead of pulling from NVRAM
if [ -f /root/temp-settings ]; then
	echo "Temp settings found, using them..."
	. /root/temp-settings
if [ -z ${autostart} ]; then
        export autostart=$autostart_def
fi
if [ -z ${center_freq} ]; then
        export center_freq=$center_freq_def
fi
if [ -z ${start_freq} ]; then
        export start_freq=$start_freq_def
fi
if [ -z ${samp_rate} ]; then
        export samp_rate=$samp_rate_def
fi
if [ -z ${start_mod} ]; then
        export start_mod=$start_mod_def
fi
if [ -z ${rf_gain} ]; then
        export rf_gain=$rf_gain_def
fi
if [ -z ${ppm} ]; then
        export ppm=$ppm_def
fi
	echo ""
	echo "Current settings are:"
	echo "Auto-start = $autostart"
	echo "Center frequency = $center_freq"
	echo "Starting frequency = $start_freq"
	echo "Sample rate = $samp_rate"
	echo "Starting demodulator = $start_mod"
	echo "RF gain = $rf_gain"
	echo "PPM = $ppm"
	echo ""
else
echo "No temp settings found, pulling from NVRAM and saving to temp file..."
export `fw_printenv autostart`
if [ -z ${autostart} ]; then
        export autostart=$autostart_def
fi
export `fw_printenv center_freq`
if [ -z ${center_freq} ]; then
        export center_freq=$center_freq_def
fi
export `fw_printenv start_freq`
if [ -z ${start_freq} ]; then
        export start_freq=$start_freq_def
fi
export `fw_printenv samp_rate`
if [ -z ${samp_rate} ]; then
        export samp_rate=$samp_rate_def
fi
if [ -z ${start_mod} ]; then
        export start_mod=$start_mod_def
fi
export `fw_printenv rf_gain`
if [ -z ${rf_gain} ]; then
        export rf_gain=$rf_gain_def
fi
export `fw_printenv ppm`
if [ -z ${ppm} ]; then
        export ppm=$ppm_def
fi
echo "export autostart=$autostart" >/root/temp-settings
echo "export center_freq=$center_freq" >>/root/temp-settings
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
echo "Auto-start = $autostart"
echo "Center frequency = $center_freq"
echo "Starting frequency = $start_freq"
echo "Sample rate = $samp_rate"
echo "Starting demodulator = $start_mod"
echo "RF gain = $rf_gain"
echo "PPM = $ppm"
echo ""
fi
