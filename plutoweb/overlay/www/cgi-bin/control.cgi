#!/bin/sh

APP=${QUERY_STRING#*app=}
APP=${APP%%&*}
APP=${APP//+/ }

echo "Starting $APP: in a second<br>"

if [ "$APP" == "openwebrx" ]; then
FREQ=${QUERY_STRING#*freq=}
FREQ=${FREQ%%&*}
FREQ=${FREQ//+/ }
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
echo "Content-type: text/html"
echo ""
echo "<html><head><title>Starting OpenWebRX"
echo "</title></head><body>"

echo "<h1>OpenWebRX:</h1><br><br>"

echo "Starting OpenWebRX on $FREQ: <br>"
echo "Sample rate: $SRATE"
echo "$DMOD demodulation with $GAIN dB of gain and a PPM correction of $PPM<br><br>"
echo "</body></html>"
/bin/settings.sh -r openwebrx -c $FREQ -s $FREQ -d $DMOD -g $GAIN -p $PPM -S $SRATE

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

else
	
	echo "Content-type: text/html"
	echo ""
	echo "<html><head><title>Starting SoapyRemote"
	echo "</title></head><body>"
	echo "<h1>"I think I broke it Beavis"</h1><br><br>"
	echo "</body></html>"
fi