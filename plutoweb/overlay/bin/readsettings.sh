#!/bin/sh
## Source this file for default and/or previous settings

# Get network info for OpenWebRX
export hostname=`hostname`
export ip=`ifconfig eth0 2> /dev/null | grep -m 1 -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | head -n1`
[ -z ${ip} ] && export ip=`ifconfig wlan0 2> /dev/null | grep -m 1 -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | head -n1`
[ -z ${ip} ] && export ip=`ifconfig usb0 2> /dev/null | grep -m 1 -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | head -n1`

# Set defaults if no previous setting(s) found
# These defaults are 3 users max showing Chicago PD freq
autostart_def=openwebrx
autoreboot_def=0
autoupdate_def=n
center_freq_def=460250000
start_freq_def=460102200
samp_rate_def=600000
start_mod_def=nfm
rf_gain_def=73
ppm_def=0
web_port_def=8073
max_clients_def=3
receiver_name_def="PlutoSDR - OpenWebRX"
receiver_location_def="Planet Earth"
receiver_qra_def=____
receiver_asl_def=____
receiver_ant_def="____"
receiver_admin_def="____"
receiver_gps_def=0.000000,0.000000
sdrhu_key_def=""
sdrhu_public_listing_def=False
fft_fps_def=10
fft_size_def=4096
fft_voverlap_factor_def=0.3
openwebrx_override_def=0
updatesrunning_def=n

# Reset environment before starting
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
receiver_name=
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
openwebrx_override=

## Use temp settings if they exist instead of pulling from NVRAM
if [ -f /root/plutoweb.conf ]; then
	echo "Temp settings found, using them..."
	. /root/plutoweb.conf
[ -z ${autostart} ] && export autostart=$autostart_def
[ -z ${autoreboot} ] && export autoreboot=$autoreboot_def
[ ${autoreboot} = "y" ] && export autoreboot=12
[ ${autoreboot} = "n" ] && export autoreboot=0
[ -z ${autoupdate} ] && export autoupdate=$autoupdate_def
[ -z ${center_freq} ] && export center_freq=$center_freq_def
[ -z ${start_freq} ] && export start_freq=$start_freq_def
[ -z ${samp_rate} ] && export samp_rate=$samp_rate_def
[ -z ${start_mod} ] && export start_mod=$start_mod_def
[ -z ${rf_gain} ] && export rf_gain=$rf_gain_def
[ -z ${ppm} ] && export ppm=$ppm_def
[ -z ${web_port} ] && export web_port=$web_port_def
[ -z ${max_clients} ] && export max_clients=$max_clients_def
[ -z "${receiver_name}" ] && export receiver_location=\"$receiver_name_def\"
[ -z "${receiver_location}" ] && export receiver_location=\"$receiver_location_def\"
[ -z ${receiver_qra} ] && export receiver_qra=$receiver_qra_def
[ -z ${receiver_asl} ] && export receiver_asl=$receiver_asl_def
[ -z "${receiver_ant}" ] && export receiver_ant=\"$receiver_ant_def\"
[ -z ${receiver_admin} ] && export receiver_admin=$receiver_admin_def
[ -z ${receiver_gps} ] && export receiver_gps=$receiver_gps_def
[ -z ${fft_fps} ] && export fft_fps=$fft_fps_def
[ -z ${fft_size} ] && export fft_size=$fft_size_def
[ -z ${fft_voverlap_factor} ] && export fft_voverlap_factor=$fft_voverlap_factor_def
[ -z ${sdrhu_key} ] && export sdrhu_key=$sdrhu_key_def
[ -z ${sdrhu_public_listing} ] && export sdrhu_public_listing=$sdrhu_public_listing_def
[ -z ${openwebrx_override} ] && export openwebrx_override=$openwebrx_override_def
[ -z ${updatesrunning} ] && export updatesrunning=$updatesrunning_def
	echo ""
	echo "Current settings are:"
	echo "Auto-start = $autostart"
	echo "Auto-reboot = $autoreboot"
	echo "Auto-update = $autoupdate"
	echo "Center frequency = $center_freq"
	echo "Starting frequency = $start_freq"
	echo "Sample rate = $samp_rate"
	echo "Starting demodulator = $start_mod"
	echo "RF gain = $rf_gain"
	echo "PPM = $ppm"
	echo "web_port = $web_port"
	echo "max_clients = $max_clients"
	echo "receiver_name = \"$receiver_name\""
	echo "receiver_location = \"$receiver_location\""
	echo "receiver_qra = $receiver_qra"
	echo "receiver_asl = $receiver_asl"
	echo "receiver_ant = \"$receiver_ant\""
	echo "receiver_admin = $receiver_admin"
	echo "receiver_gps = $receiver_gps"
	echo "fft_fps = $fft_fps"
	echo "fft_size = $fft_size"
	echo "fft_voverlap_factor = $fft_voverlap_factor"
	echo "sdrhu_key = $sdrhu_key"
	echo "sdrhu_public_listing = $sdrhu_public_listing"
	echo "openwebrx_override = $openwebrx_override"
	echo "Active IP and hostname = $ip / $hostname"
	echo "Updates running = $updatesrunning"
	echo ""
else
echo "No temp settings found, pulling from NVRAM and saving to temp file..."
export autostart=`fw_printenv -n autostart 2> /dev/null || echo $autostart_def`
export autoreboot=`fw_printenv -n autoreboot 2> /dev/null || echo $autoreboot_def`
export autoupdate=`fw_printenv -n autoupdate 2> /dev/null || echo $autoupdate_def`
export center_freq=`fw_printenv -n center_freq 2> /dev/null || echo $center_freq_def`
export start_freq=`fw_printenv -n start_freq 2> /dev/null || echo $start_freq_def`
export samp_rate=`fw_printenv -n samp_rate 2> /dev/null || echo $samp_rate_def`
export start_mod=`fw_printenv -n start_mod 2> /dev/null || echo $start_mod_def`
export rf_gain=`fw_printenv -n rf_gain 2> /dev/null || echo $rf_gain_def`
export ppm=`fw_printenv -n ppm 2> /dev/null || echo $ppm_def`
export web_port=`fw_printenv -n web_port 2> /dev/null || echo $web_port_def`
export max_clients=`fw_printenv -n max_clients 2> /dev/null || echo $max_clients_def`
export receiver_name=`fw_printenv -n receiver_name 2> /dev/null || echo \"$receiver_name_def\"`
export receiver_location=`fw_printenv -n receiver_location 2> /dev/null || echo \"$receiver_location_def\"`
export receiver_qra=`fw_printenv -n receiver_qra 2> /dev/null || echo $receiver_qra_def`
export receiver_asl=`fw_printenv -n receiver_asl 2> /dev/null || echo $receiver_asl_def`
export receiver_ant=`fw_printenv -n receiver_ant 2> /dev/null || echo \"$receiver_ant_def\"`
export receiver_admin=`fw_printenv -n receiver_admin 2> /dev/null || echo $receiver_admin_def`
export receiver_gps=`fw_printenv -n receiver_gps 2> /dev/null || echo $receiver_gps_def`
export fft_fps=`fw_printenv -n fft_fps 2> /dev/null || echo $fft_fps_def`
export fft_size=`fw_printenv -n fft_size 2> /dev/null || echo $fft_size_def`
export fft_voverlap_factor=`fw_printenv -n fft_voverlap_factor 2> /dev/null || echo $fft_voverlap_factor_def`
export sdrhu_key=`fw_printenv -n sdrhu_key 2> /dev/null || echo ""`
export sdrhu_public_listing=`fw_printenv -n sdrhu_public_listing 2> /dev/null || echo $sdrhu_public_listing_def`
export openwebrx_override=`fw_printenv -n openwebrx_override 2> /dev/null || echo $openwebrx_override_def`

# Create /root/plutoweb.conf
echo "export autostart=$autostart" >/root/plutoweb.conf
echo "export autoreboot=$autoreboot" >>/root/plutoweb.conf
echo "export autoupdate=$autoupdate" >>/root/plutoweb.conf
echo "export center_freq=$center_freq" >>/root/plutoweb.conf
echo "export start_freq=$start_freq" >>/root/plutoweb.conf
echo "export samp_rate=$samp_rate" >>/root/plutoweb.conf
echo "export start_mod=$start_mod" >>/root/plutoweb.conf
echo "export rf_gain=$rf_gain" >>/root/plutoweb.conf
echo "export ppm=$ppm" >>/root/plutoweb.conf
echo "export web_port=$web_port" >>/root/plutoweb.conf
echo "export max_clients=$max_clients" >>/root/plutoweb.conf
echo "export receiver_name=$receiver_name" >>/root/plutoweb.conf
echo "export receiver_location=$receiver_location" >>/root/plutoweb.conf
echo "export receiver_qra=$receiver_qra" >>/root/plutoweb.conf
echo "export receiver_asl=$receiver_asl" >>/root/plutoweb.conf
echo "export receiver_ant=$receiver_ant" >>/root/plutoweb.conf
echo "export receiver_admin=$receiver_admin" >>/root/plutoweb.conf
echo "export receiver_gps=$receiver_gps" >>/root/plutoweb.conf
echo "export fft_fps=$fft_fps" >>/root/plutoweb.conf
echo "export fft_size=$fft_size" >>/root/plutoweb.conf
echo "export fft_voverlap_factor=$fft_voverlap_factor" >>/root/plutoweb.conf
echo "export sdrhu_key=$sdrhu_key" >>/root/plutoweb.conf
echo "export sdrhu_public_listing=$sdrhu_public_listing" >>/root/plutoweb.conf
echo "export openwebrx_override=$openwebrx_override" >>/root/plutoweb.conf
echo "export updatesrunning=$updatesrunning" >>/root/plutoweb.conf
chmod +x /root/plutoweb.conf
echo ""
echo "Current settings are:"
echo "Auto-start = $autostart"
echo "Auto-reboot = $autoreboot"
echo "Auto-update = $autoupdate"
echo "Center frequency = $center_freq"
echo "Starting frequency = $start_freq"
echo "Sample rate = $samp_rate"
echo "Starting demodulator = $start_mod"
echo "RF gain = $rf_gain"
echo "PPM = $ppm"
echo "web_port = $web_port"
echo "max_clients = $max_clients"
echo "receiver_name = $receiver_name"
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
echo "openwebrx_override = $openwebrx_override"
echo "Active IP and hostname = $ip / $hostname"
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
echo $receiver_name >>/www/settings.txt
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
echo $hostname >>/www/settings.txt
echo $ip >>/www/settings.txt
echo $openwebrx_override >>/www/settings.txt

# Create SQLite3 DB
rm -f /www/settings.sqlite3 /tmp/.sql
sqlite3 /www/settings.sqlite3 "CREATE TABLE settings (setting CHAR(50), value CHAR(50));"
IFS=$'\n'
for i in $(cat /root/plutoweb.conf | sed 's/export //g'); do
setting=`echo "$i" | awk -F= '{ print $1 }'`
value=`echo "$i" | awk -F= '{ print $2 }'`
echo "INSERT INTO settings (setting,value) VALUES('$setting','$value');" >>/tmp/.sql
done
sqlite3 /www/settings.sqlite3 </tmp/.sql
rm -f /tmp/.sql
