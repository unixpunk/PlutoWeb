#!/bin/sh

APP=${QUERY_STRING#*app=}
APP=${APP%%&*}
APP=${APP//+/ }

# AREBOOT=${QUERY_STRING#*auto-reboot=}
# AREBOOT=${AREBOOT%%&*}
# AREBOOT=${AREBOOT//+/ }
# if [ "$AREBOOT" == "autoreboot" ]; then

# $AREBOOT = "-R y"; else
# $AREBOOT = "-R n"

if [ "$APP" == "openwebrx" ]; then
FREQ=${QUERY_STRING#*freq=}
FREQ=${FREQ%%&*}
FREQ=${FREQ//+/ }
SFREQ=${QUERY_STRING#*sfreq=}
SFREQ=${SFREQ%%&*}
SFREQ=${SFREQ//+/ }
DMOD=${QUERY_STRING#*dmod=}
DMOD=${DMOD%%&*}
DMOD=${DMOD//+/ }
GAIN=${QUERY_STRING#*gain=}
GAIN=${GAIN%%&*}
GAIN=${GAIN//+/ }
PPM=${QUERY_STRING#*ppm=}
PPM=${PPM%%&*}
PPM=${PPM//+/ }
SRATE=${QUERY_STRING#*srate=}
SRATE=${SRATE%%&*}
SRATE=${SRATE//+/ }
TEST=$(uptime)
echo "Content-type: text/html"
echo ""
echo "<html><head><title>Starting OpenWebRX"
echo "</title></head><body>"

echo "<h1>OpenWebRX:</h1><br><br>"

echo "Starting OpenWebRX on $FREQ: <br>"
echo "With $SFREQ as a starting freq<br>"
echo "Sample rate: $SRATE"
echo "$DMOD demodulation with $GAIN dB of gain and a PPM correction of $PPM<br>Uptime: $TEST<br>"
echo "</body></html>"
/bin/settings.sh -r openwebrx -c $FREQ -s $SFREQ -d $DMOD -g $GAIN -p $PPM -S $SRATE

elif [ "$APP" == "dump1090" ]; then

echo "Content-type: text/html"
echo ""
echo "<html><head><title>Starting Dump1090"
echo "</title></head><body>"

echo "<h1>Dump1090</h1><br><br>"

echo "Starting Dump1090 on port 8080 <br><br><br>"
echo "</body></html>"
/bin/settings.sh -r dump1090

elif [ "$APP" == "soapy" ]; then

echo "Content-type: text/html"
echo ""
echo "<html><head><title>Starting SoapyRemote"
echo "</title></head><body>"

echo "<h1>SoapyRemote:</h1><br><br>"

echo "Starting SoapyRemote<br><br><br>"
echo "</body></html>"
/bin/settings.sh -r SoapyRemote

elif [ "$APP" == "settings" ]; then

echo "Content-type: text/html"
echo ""
echo "<html><head><title>Saving Settings"
echo "</title></head><body>"

echo "<h1>Saving Settings</h1><br><br>"

FREQ=${QUERY_STRING#*freq=}
FREQ=${FREQ%%&*}
FREQ=${FREQ//+/ }
SFREQ=${QUERY_STRING#*sfreq=}
SFREQ=${SFREQ%%&*}
SFREQ=${SFREQ//+/ }
DMOD=${QUERY_STRING#*dmod=}
DMOD=${DMOD%%&*}
DMOD=${DMOD//+/ }
GAIN=${QUERY_STRING#*gain=}
GAIN=${GAIN%%&*}
GAIN=${GAIN//+/ }
PPM=${QUERY_STRING#*ppm=}
PPM=${PPM%%&*}
PPM=${PPM//+/ }
SRATE=${QUERY_STRING#*srate=}
SRATE=${SRATE%%&*}
SRATE=${SRATE//+/ }
ASTART=${QUERY_STRING#*astart=}
ASTART=${ASTART%%&*}
ASTART=${ASTART//+/ }
AUPDATE=${QUERY_STRING#*aupdate=}
AUPDATE=${AUPDATE%%&*}
AUPDATE=${AUPDATE//+/ }
AREBOOT=${QUERY_STRING#*areboot=}
AREBOOT=${AREBOOT%%&*}
AREBOOT=${AREBOOT//+/ }
NVRAM=${QUERY_STRING#*nvram=}
NVRAM=${NVRAM%%&*}
NVRAM=${NVRAM//+/ }
/bin/settings.sh -r $ASTART -c $FREQ -s $SFREQ -d $DMOD -g $GAIN -p $PPM -S $SRATE -u $AUPDATE -R $AREBOOT -W $NVRAM

echo "Settings have been saved.<br><br><br>"
echo "</body></html>"

elif [ "$APP" == "wipe" ]; then

echo "Content-type: text/html"
echo ""
echo "<html><head><title>Erasing settings from NVRAM"
echo "</title></head><body>"

echo "<h1>Erasing setings</h1><br><br>"

echo "The settings have been erased from NVRAM<br><br><br>"
echo "</body></html>"
/bin/settings.sh -E y

elif [ "$APP" == "reboot" ]; then

echo "Content-type: text/html"
echo ""
echo "<html><head><title>Rebooting PlutoSDR"
echo "</title></head><body>"

echo "<h1>Rebooting the PlutoSDR</h1><br><br>"

echo "The PlutoSDR is being rebooted please give it a minute.<br><br><br>"
echo "</body></html>"
reboot

else
	
	echo "Content-type: text/html"
	echo ""
	echo "<html><head><title>Error"
	echo "</title></head><body>"
	echo "<h1>"I think you broke it Beavis. You dumbass."</h1><br><br>"
	echo "</body></html>"
fi
