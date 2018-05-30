#!/bin/sh
## Source this file for default and/or previous settings

# Set defaults if no previous settings found
# Persistent variables
autostart_def=openwebrx
autoreboot_def=12
autoupdate_def=y
center_freq_def=460250000
start_freq_def=460102200
samp_rate_def=600000
start_mod_def=nfm
rf_gain_def=89
ppm_def=0
web_port_def=8073
max_clients_def=3
receiver_location_def="\"Planet Earth\""
receiver_qra_def=ABC123
receiver_asl_def=0
receiver_ant_def=Wideband
receiver_admin_def=""
receiver_gps_def=0.000000,0.000000
sdrhu_key_def=""
sdrhu_public_listing_def=False
fft_fps_def=5
fft_size_def=4096
fft_voverlap_factor_def=0.1


# Leave these all empty
autostart=
autoreboot=
autoupdate=
center_freq=
start_freq=
samp_rate=
start_mod=
rf_gain=
ppm=
web_port=
max_clients=
receiver_location=
receiver_qra=
receiver_asl=
receiver_ant=
receiver_admin=
receiver_gps=
fft_fps=
fft_size=
fft_voverlap_factor=
sdrhu_key=
sdrhu_public_listing=

# Non-persistent variables
updatesrunning_def=n

## Use temp settings if they exist instead of pulling from NVRAM
if [ -f /root/temp-settings ]; then
	echo "Temp settings found, using them..."
	. /root/temp-settings
if [ -z ${autostart} ]; then
        export autostart=$autostart_def
fi
if [ -z ${autoreboot} ]; then
        export autoreboot=$autoreboot_def
fi
if [ ${autoreboot} = "y" ]; then
        export autoreboot=12
fi
if [ ${autoreboot} = "n" ]; then
        export autoreboot=0
fi
if [ -z ${autoupdate} ]; then
        export autoupdate=$autoupdate_def
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
if [ -z ${web_port} ]; then
        export web_port=$web_port_def
fi
if [ -z ${max_clients} ]; then
        export max_clients=$max_clients_def
fi
if [ -z ${receiver_location} ]; then
        export receiver_location=$receiver_location_def
fi
if [ -z ${receiver_qra} ]; then
        export receiver_qra=$receiver_qra_def
fi
if [ -z ${receiver_asl} ]; then
        export receiver_asl=$receiver_asl_def
fi
if [ -z ${receiver_ant} ]; then
        export receiver_ant=$receiver_ant_def
fi
if [ -z ${receiver_admin} ]; then
        export receiver_admin=$receiver_admin_def
fi
if [ -z ${receiver_gps} ]; then
        export receiver_gps=$receiver_gps_def
fi
if [ -z ${fft_fps} ]; then
        export fft_fps=$fft_fps_def
fi
if [ -z ${fft_size} ]; then
        export fft_size=$fft_size_def
fi
if [ -z ${fft_voverlap_factor} ]; then
        export fft_voverlap_factor=$fft_voverlap_factor_def
fi
if [ -z ${sdrhu_key} ]; then
        export sdrhu_key=$sdrhu_key_def
fi
if [ -z ${sdrhu_public_listing} ]; then
        export sdrhu_public_listing=$sdrhu_public_listing_def
fi
if [ -z ${updatesrunning} ]; then
        export updatesrunning=$updatesrunning_def
fi
	echo ""
	echo "Current settings are:"
	echo "Auto-start = $autostart"
	echo "Auto-reboot = $autoreboot"
	echo "Auto-update = $autoupdate"
	echo "Updates running = $updatesrunning"
	echo "Center frequency = $center_freq"
	echo "Starting frequency = $start_freq"
	echo "Sample rate = $samp_rate"
	echo "Starting demodulator = $start_mod"
	echo "RF gain = $rf_gain"
	echo "PPM = $ppm"
	echo "web_port = $web_port"
	echo "max_clients = $max_clients"
	echo "receiver_location = $receiver_location"
	echo "receiver_qra = $receiver_qra"
	echo "receiver_asl = $receiver_asl"
	echo "receiver_ant = $receiver_ant"
	echo "receiver_admin = $receiver_admin"
	echo "receiver_gps = $receiver_gps"
	echo "fft_fps = $fft_fps"
	echo "fft_size = $fft_size"
	echo "fft_voverlap_factor = $fft_voverlap_factor"
	echo "sdrhu_key = $sdrhu_key"
	echo "sdrhu_public_listing = $sdrhu_public_listing"
	echo ""
else
echo "No temp settings found, pulling from NVRAM and saving to temp file..."
export `fw_printenv autostart`
if [ -z ${autostart} ]; then
        export autostart=$autostart_def
fi
export `fw_printenv autoreboot`
if [ -z ${autoreboot} ]; then
        export autoreboot=$autoreboot_def
fi
export `fw_printenv autoupdate`
if [ -z ${autoupdate} ]; then
        export autoupdate=$autoupdate_def
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
export `fw_printenv web_port`
if [ -z ${web_port} ]; then
        export web_port=$web_port_def
fi
export `fw_printenv max_clients`
if [ -z ${max_clients} ]; then
        export max_clients=$max_clients_def
fi
export `fw_printenv receiver_location`
if [ -z ${receiver_location} ]; then
        export receiver_location=$receiver_location_def
fi
export `fw_printenv receiver_qra`
if [ -z ${receiver_qra} ]; then
        export receiver_qra=$receiver_qra_def
fi
export `fw_printenv receiver_asl`
if [ -z ${receiver_asl} ]; then
        export receiver_asl=$receiver_asl_def
fi
export `fw_printenv receiver_ant`
if [ -z ${receiver_ant} ]; then
        export receiver_ant=$receiver_ant_def
fi
export `fw_printenv receiver_admin`
if [ -z ${receiver_admin} ]; then
        export receiver_admin=$receiver_admin_def
fi
export `fw_printenv receiver_gps`
if [ -z ${receiver_gps} ]; then
        export receiver_gps=$receiver_gps_def
fi
export `fw_printenv fft_fps`
if [ -z ${fft_fps} ]; then
        export fft_fps=$fft_fps_def
fi
export `fw_printenv fft_size`
if [ -z ${fft_size} ]; then
        export fft_size=$fft_size_def
fi
export `fw_printenv fft_voverlap_factor`
if [ -z ${fft_voverlap_factor} ]; then
        export fft_voverlap_factor=$fft_voverlap_factor_def
fi
export `fw_printenv sdrhu_key`
if [ -z ${sdrhu_key} ]; then
        export sdrhu_key=$sdrhu_key_def
fi
export `fw_printenv sdrhu_public_listing`
if [ -z ${sdrhu_public_listing} ]; then
        export sdrhu_public_listing=$sdrhu_public_listing_def
fi
if [ -z ${updatesrunning} ]; then
        export updatesrunning=$updatesrunning_def
fi

# Create /root/temp-settings
echo "export autostart=$autostart" >/root/temp-settings
echo "export autoreboot=$autoreboot" >>/root/temp-settings
echo "export autoupdate=$autoupdate" >>/root/temp-settings
echo "export center_freq=$center_freq" >>/root/temp-settings
echo "export start_freq=$start_freq" >>/root/temp-settings
echo "export samp_rate=$samp_rate" >>/root/temp-settings
echo "export start_mod=$start_mod" >>/root/temp-settings
echo "export rf_gain=$rf_gain" >>/root/temp-settings
echo "export ppm=$ppm" >>/root/temp-settings
echo "export web_port=$web_port" >>/root/temp-settings
echo "export max_clients=$max_clients" >>/root/temp-settings
echo "export receiver_location=$receiver_location" >>/root/temp-settings
echo "export receiver_qra=$receiver_qra" >>/root/temp-settings
echo "export receiver_asl=$receiver_asl" >>/root/temp-settings
echo "export receiver_ant=$receiver_ant" >>/root/temp-settings
echo "export receiver_admin=$receiver_admin" >>/root/temp-settings
echo "export receiver_gps=$receiver_gps" >>/root/temp-settings
echo "export fft_fps=$fft_fps" >>/root/temp-settings
echo "export fft_size=$fft_size" >>/root/temp-settings
echo "export fft_voverlap_factor=$fft_voverlap_factor" >>/root/temp-settings
echo "export sdrhu_key=$sdrhu_key" >>/root/temp-settings
echo "export sdrhu_public_listing=$sdrhu_public_listing" >>/root/temp-settings
echo "export updatesrunning=$updatesrunning" >>/root/temp-settings
chmod +x /root/temp-settings
echo ""
echo "Ignore any messages above this line..."
echo ""
echo "Current settings are:"
echo "Auto-start = $autostart"
echo "Auto-reboot = $autoreboot"
echo "Auto-update = $autoupdate"
echo "Updates running = $updatesrunning"
echo "Center frequency = $center_freq"
echo "Starting frequency = $start_freq"
echo "Sample rate = $samp_rate"
echo "Starting demodulator = $start_mod"
echo "RF gain = $rf_gain"
echo "PPM = $ppm"
echo "web_port = $web_port"
echo "max_clients = $max_clients"
echo "receiver_location = $receiver_location"
echo "receiver_qra = $receiver_qra"
echo "receiver_asl = $receiver_asl"
echo "receiver_ant = $receiver_ant"
echo "receiver_admin = $receiver_admin"
echo "receiver_gps = $receiver_gps"
echo "fft_fps = $fft_fps"
echo "fft_size = $fft_size"
echo "fft_voverlap_factor = $fft_voverlap_factor"
echo "sdrhu_key = $sdrhu_key"
echo "sdrhu_public_listing = $sdrhu_public_listing"
echo "Update running = $updatesrunning"
echo ""
fi

# Create /www/settings.txt
echo $autostart >/www/settings.txt
echo $autoreboot >>/www/settings.txt
echo $autoupdate >>/www/settings.txt
echo $center_freq >>/www/settings.txt
echo $start_freq >>/www/settings.txt
echo $samp_rate >>/www/settings.txt
echo $start_mod >>/www/settings.txt
echo $rf_gain >>/www/settings.txt
echo $ppm >>/www/settings.txt
echo $web_port >>/www/settings.txt
echo $max_clients >>/www/settings.txt
echo $receiver_location >>/www/settings.txt
echo $receiver_qra >>/www/settings.txt
echo $receiver_asl >>/www/settings.txt
echo $receiver_ant >>/www/settings.txt
echo $receiver_admin >>/www/settings.txt
echo $receiver_gps >>/www/settings.txt
echo $fft_fps >>/www/settings.txt
echo $fft_size >>/www/settings.txt
echo $fft_voverlap_factor >>/www/settings.txt
echo $sdrhu_key >>/www/settings.txt
echo $sdrhu_public_listing >>/www/settings.txt
