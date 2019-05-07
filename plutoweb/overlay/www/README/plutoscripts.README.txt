Some scripts I'm using for the Pluto.
Should work on every Pluto if corresponding applications are installed.
Adapt to your needs and correct my mistakes.


Full doc, once flashed see USB-drive/README.txt or : https://github.com/LamaBleu/plutoscripts/tree/master/USB-drive

Screenshots, firmware including the scripts and apps, download link : 
https://mega.nz/#F!C8hgFASK!C9DfCjU7ou46mG-LNWQTrQ

*** Update 15/03/2019  
 
 - Added NFS filesystem support (under NFS subfolder).  
  You can now mount remote shares using NFS through USB or Wifi, save records and scripts.  
  Use "nfs_server=" parameter in config.txt to set the remote share to connect.  
  At mount a script is run to allow you customize your pluto.  
    
- It's also possible to mount a remote directory as root filesystem, however this is full of bugs, experimental.  
  As example I provide 2 filesystems sample, a classic one (mirror of the firmware), and another big one (BFR-filesystem) containing lot of application we can't fit together on the internal flash of Pluto.  
  
- Added delaycmd in config.txt to start commands one minute after boot.

More details in the NFS-readme.txt file.  
  
  
*** Update 27/01/2019

- wifi is back. Most of tested wifi dongles are supported.
However it seems Pluto is not able to connect wifi network containing spaces or special characters in SSID name.
- Added utilities : jq socat sox pv and more
- Added global variables CALLSIGN LOCATOR FREQUENCY you can use for scripting 
     (example : CW-pluto.py $FREQUENCY "CQ CQ DE $CALLSIGN").
  Set correct values in config.txt file, [HAMRADIO] section (eject then reboot). 

- DATV improved.
- Many many thanks to @F5OEO_Evariste for sharing his exprience on DATV and RPi !
-->  it's now possible to use  webcam on RPi, send videostream to Pluto and transmit via DATV using Pluto..
        All mobile. see details on DATV section


*** Update 19/01/2019
- added plot10.sh, plot20.sh to plot 10MHZ or 20MHz spectrum using LUAradio
- added pplot10.sh pplot20.sh, same task running in permanent loop.
- LUAradio : added AM demodulators, POCSAG OK.
- Upgraded to libiio 0.17, soapyremote 0.5. SoapySDR still stuck at 0.6.1 :(
- Most signifiant scripts are now available here : https://github.com/LamaBleu/plutoscripts



PRE-REQUISITE :

Twitter @5GReady user first reported an issue on flashing failing at around 22-23 MB (firmware filesize is 32MB)

Few investigations showed a batch of 1000 Plutos are not able to support flashing firmware file over 22MB size.
It's always possible to downgrade back to official 0.29 version using same DFU command, no worries.




***** How to find  if your pluto device is coming from the first batch (0) or not (1) :

Type following command :    iio_info | grep variant
 result :    hw_model_variant : 1       --->    compatible with this firmware, 
                                0       --->    not compatible (or apply workaround at your own risk).  

If you get a "0" result, then do not try to flash this version, wasted time.
You can also check on the dmesg log if reported n25q256a (not compatible, or apply workaround to unlock) or n25q512a (compatible)
Download the "light-version" instead, compatible with all revB boards.
Workaround exists, be prudent : https://ez.analog.com/university-program/f/q-a/105941/adalm-pluto---firmware-dfu-flashing-fails-at-22-23mb/313815

INSTALLED APPLICATIONS
======================

- iio tools : iio-info, libiio 0.16
- CW generator (python) (FG8OJ for CW processing code : https://github.com/fg8oj/cwkeyer)
- SoapySDR + SoapyRemote 0.6 (Pothosware https://github.com/pothosware/SoapySDR) 
- LeanTRX ( + DATV TX scripts)  (F4DAV and PABR team http://www.pabr.org/radio/leantrx/leantrx.en.html)
- rpidatv.ts video sample to send video test stream directly from Pluto (courtesy F5OEO)
- Python 2.7 (+numpy, also  including iio and SoapySDR bindings)
- rxtools : rx_sdr, rx_fm, rx_power ( Robert X. Seger https://github.com/rxseger/rx_tools)
- LUAradio (Vanya Sergeev http://luaradio.io)
- csdr ( + nmux) (Simonyi Károly College for Advanced Studies https://github.com/simonyiszk/csdr)
- gnuplot + libpng  
- Busybox utilities  : netcat, timeout, ntpd and more (at and timeout to perform scheduled tasks or end a task).
- Retrogram  (Peter Rakesh https://github.com/r4d10n/retrogram-plutosdr)
- multimon-ng (Elias Önal https://github.com/EliasOenal/multimon-ng/)
- OpenWebRX (András Retzler HA7ILM https://sdr.hu)
- morfeus_tool

* SoapySDR note : yes I know it's not the last version, and I know why ;) WIP
* Cross-compiled apps, except : leantrx 
* nmux note : nmux is a very good TCP listener, allowing several clients at the same time, keeping listener running after disconnection.


FLASHING
========



Be always prudent when flashing. Pluto seems very robust !
It is better to flash official 0.29 firmware before.

My preference goes to DFU flashing (never failed) - you need to have dfu-utils installed.
 1. Change to the directory you downloaded the firmware
 2. Ask your Pluto to reboot in DFU mode :
     - from SSH enter "device_reboot sf"  --> pluto will reboot to DFUI mode (fixed left LED)
  or - modify config.txt file on the USB Mass Storage : in [ACTIONS] section change to 'dfu = 1', then eject drive.
 3. Run "dfu-util -a firmware.dfu -D pluto.dfu"


                
               Copyright 2005-2009 Weston Schmidt, Harald Welte and OpenMoko Inc.
               Copyright 2010-2014 Tormod Volden and Stefan Schmidt
               This program is Free Software and has ABSOLUTELY NO WARRANTY
               Please report bugs to dfu-util@lists.gnumonks.org

               Match vendor ID from file: 0456
               Match product ID from file: b673
               Opening DFU capable USB device...
               ID 0456:b674
               Run-time device DFU version 0110
               Claiming USB DFU Interface...
               Setting Alternate Setting #1 ...
               Determining dev ice status: state = dfuIDLE, status = 0
               DFU mode device DFU version 0110
               Device returned transfer size 4096
               Copying data from PC to DFU device
               Download	[=========================] 100%     21353903 bytes
               Download done.
               state(7) = dfuMANIFEST, status(0) = No error condition is present
               state(2) = dfuIDLE, status(0) = No error condition is present
               Done!

Reference


- Internet access.

By default Pluto is set to start network with static IP.
Fixed IP adresses are :192.168.2.10 (for host computer) and 192.168.2.1 (pluto) are still valid.
Using this configuration, internet access is not possible.
You have to switch to DHCP (USB shared connection or WiFi)

Wifi and network settings: update config.txt file on the USB Storage drive, then eject to update settings.


- NTP time
Pluto will try to get current time using ntp from following servers : 192.168.2.10 pool.ntp.org
If you choose to run on static IP configuration, Pluto will probably not access internet, but might be able to get current date/time setting if a time server is running on your host computer 192.168.2.10



- USB mass storage : transfer files to/from pluto.
Hard to explain in few words ! To copy file to/from pluto, you can use the USB Mass Storage from host computer and /gadget on Pluto side.

Procedure:
- copy files to PlutoSDR drive
- eject (unmount) the drive. Will re-appear few seconds later.
- on the pluto side, from SSH run usb-drive.sh
- a copy of PlutoSDR will appear on /gadget folder.

You have to sync /gadget <--> USB mass storage each time you copy file.
Just to be sure, check files timestamp.

I agree, this need some training ;) 




CW keyer:
=========

The python script comes from Bertrand FG8OJ, adapted for Pluto. It's a smooth mix of libiio, bash-iio  and iio_attrib use ;)
Run following python script  located in /root : python /root/CW-pluto.py -f 144350000 -w 13 "CQ CQ CQ TEST"
  --> frequency -f parameter can be omitted, default frequency is 434 MHz

LUARADIO : 
==========

Luaradio is a LUA application to demodulate and process SDR signals.
It works using scripting, easy to understand.
However LUAradio soesn't seems to be maintained anymore. more : http://luaradio.io
(last minute: the author of LUAradio announces a 1.0 version to be released in 2019)

 
It's best to change directory before use (cd /root/luaradio), at least when running examples scripts.
noaa_pluto.lua : rate 11025
nbfm_pluto.lua : rate 48000
wbfm_mono_pluto.lua : rate 48000



----
Record 5 minutes NBFM on 466.205MHz (48000Hz):

# timeout -t 300 -s SIGINT ./luaradio nbfm_pluto.lua 466205000
  Recording from 466.205 to  /www/record.wav 
  [INFO] Auto setting Buffer Size: 262144

Wav file is copied to http://pluto.local/record.wav
File can be downloaded or played through VLC (open network stream: http://192.168.2.1/record.wav)
or mplayer : mplayer -cache 1024 -quiet -rawaudio http://192.168.2.1/record.wav

----
Record NOAA :

timeout -t 700 -s SIGINT luaradio noaa_pluto.lua 137100000 /www/noaa.wav

----

luaradio nbfm_pluto.lua 466205000

luaradio ax25_pluto.lua 144800000

luaradio pocsag_pluto.lua 466050000



RX_SDR and CSDR
===============
CSDR (and libcsdr) is a really nice tool dedicated to signal processing on SDR based on piped commands.
libsdr is the main sock of OpenWebRX. nmux is also included.
Refer to libsdr/openwebRX docs. Please take also few minutes to read this long post from HA7LIM : https://blog.sdr.hu/support



All these commands are very long, in one line only, take care !

Examples :

* Record 466.175 NBFM to /www/record.wav  (wav file is on /www , or http://192.168.2.1/record.wav):

rx_sdr -F CF32 -f 466175000 -s 2400000 -g 70 - | csdr fir_decimate_cc 50 0.005 HAMMING | csdr fmdemod_quadri_cf | csdr limit_ff | csdr deemphasis_nfm_ff 48000 | csdr fastagc_ff | csdr convert_f_i16 | sox -t raw -e signed -c 1 -b 16 -r 48000 - /www/record.wav



* Stream audio to 192.168.2.1:4444:
( use "nc 192.168.2.1 4444 |  mplayer -cache 1024 -quiet -rawaudio samplesize=2:channels=1:rate=48000 -demuxer rawaudio -" on the host computer)

rx_sdr -F CF32 -f 466175000 -s 2400000 -g 70 - | csdr fir_decimate_cc 50 0.005 HAMMING | csdr fmdemod_quadri_cf | csdr limit_ff | csdr deemphasis_nfm_ff 48000 | csdr fastagc_ff | csdr convert_f_i16 | nmux -p 4444 -a 10.40.0.155


* Receive POCSAG NBFM 

Pluto :

rx_sdr  -F CF32 -s 2400000 -f 466175000 -g 50 - | csdr fir_decimate_cc 50 0.005 HAMMING | csdr fmdemod_quadri_cf  | csdr limit_ff | csdr deemphasis_nfm_ff 48000 | csdr fastagc_ff | csdr convert_f_i16  | netcat -l -p 4444

Pc-client :

nc 192.168.2.1 4444 | mplayer -cache 1024 -quiet -rawaudio samplesize=2:channels=1:rate=48000 -demuxer rawaudio -
(using nc, can be remplaced by netcat, or better nmux)



* Receive WBFM using mplayer on the computer side :
A wav file is created on http://192.168.2.1/record.wav

Pluto :
 rx_sdr  -F CF32 -s 2400000 -f 105100000 -g 20 -  | csdr fir_decimate_cc 10 0.05 HAMMING | csdr fmdemod_quadri_cf | csdr fractional_decimator_ff 5  | csdr deemphasis_wfm_ff 48000 50e-6 | csdr convert_f_i16 > /www/record.wav

- PC client, get the file  at http://192.168.2.1/record.wav or listen   :
mplayer -cache 1024 -quiet -rawaudio samplesize=2:channels=1:rate=48000 -demuxer rawaudio http://192.168.2.1/record.wav

* Variant, using rx_sdr -F CF32 , csdr, nmux or netcat (see nbfm-rx.sh and wbfm-rx.sh scripts):
Audio is streamed to port pluto.local:4444

Pluto : 
(WBFM ) rx_sdr -F CF32 -s 2400000 -f 105100000 -g 70 - | csdr fir_decimate_cc 10 0.05 HAMMING | csdr fmdemod_quadri_cf | csdr fractional_decimator_ff 5  | csdr deemphasis_wfm_ff 48000 50e-6 | csdr convert_f_i16 | nmux -a 192.168.2.1 -p 4444

/root/nbfm-rx.sh script :

(NBFM) rx_sdr -F CF32 -s 2400000 -f 466175000 -g 50 - | csdr fir_decimate_cc 50 0.005 HAMMING | csdr fmdemod_quadri_cf  | csdr limit_ff | csdr deemphasis_nfm_ff 48000 | csdr fastagc_ff | csdr convert_f_i16  | netcat -l -p 4444

/root/wbfm-rx.sh script, audio 48000Hz
3MS/s  sample rate : 
rx_sdr -F CF32 -s 3000000 -f 105100000 -g 70 - | csdr fir_decimate_cc 12 0.06 HAMMING | csdr fmdemod_quadri_cf | csdr fractional_decimator_ff 5  | csdr deemphasis_wfm_ff 48000 60e-6 | csdr convert_f_i16 | nmux -a 192.168.2.1 -p 4444

PC: 
nc 192.168.2.1 4444 | mplayer -cache 1024 -quiet -rawaudio samplesize=2:channels=1:rate=48000 -demuxer rawaudio -


GNUPLOT
=======

You can create plots directly from the Pluto
Generated plot is displayed on the console using ASCII-art (vintage !).
and PNG version is available here : http://192.168.2.1/plot.png


- Plot RF signal spectrum : use signal.sh
signal.sh 1800 2600 25  55 --> plot from 800 to 2600MHz, spacing 25kHz, gain 55 (from 0 to 73, can be omitted, default 70)

Notes : signal.sh uses rx_power to get signal value. 
At this moment it will only perform one pass ( -1 ) because of CSV file formatting.
A full sweep is performed in less than 10 seconds. Time can be increased to improve result.
Example : https://imgur.com/3K8bRpf  https://imgur.com/7FgnFIT

- Plot audio record coming from /www/record.wav :
Run plot-wav.sh script. 
Will draw a plot you can view on http://192.168.2.1/plot.png
Plot processing can take lot of time, be patient.
Example : https://imgur.com/hgIMeWO

RX_FM
=======

rx_fm seems buggy using nfm mode ! But works well using wbfm. TBC .( confirmed !)
Stream to the host computer using nc, netcat, or nmux.
Wav file can also be saved to file, please refer to rx-tools doc.

Pluto: 

rx_fm  -M fm -s 170k -A fast -r 32k -l 0 -E deemp -f 105100000 -g 70 - | nc -l -p 4444   (WBFM)
rx_fm  -M nfm -A fast -r 32k -l 0 -E deemp -f 466207000 -g 70 - | nc -l -p 4444    (NFM)

streaming via nmux :

rx_fm -M fm -s 170k -A fast -r 32k -l 0 -E deemp -f 105100000 -g 70 - | nmux -a 192.168.2.1 -p 4444


Client:

nc 192.168.2.1 4444 | aplay -r 32k -f S16_LE -t raw -c 1

nc 192.168.2.1 4444 | mplayer -cache 1024 -quiet -rawaudio samplesize=2:channels=1:rate=32000 -demuxer rawaudio -




LEANTRX and DATV :
=================

LeanTRX home page is available here : http://192.168.2.1/leantrx (or pluto.local/leantrx)

Scripts : to send DATV have a look to /root/DATV folder ! Please respect rules/laws regarding RF transmission.

When receiving DATV using from the DVBRX  page(dvbrx.html), the TS stream is now redirected to 192.168.2.1:4444 using nmux.
With a bit of luck it is possible to view the stream using VLC on the host computer running :  nc 192.168.2.1 4444 | cvlc -
However it doesn't always work, depending on the stream (works well using MPEG4 stream sent from RPiDATV, 333kS/s)
See another example below, and have a look to /root/datv-rx-leandvb.sh script to get more inspiration.


MPEG4-ts sample file is no more provided on USB Mass storage for this light version.
You have to download it and copy to the USB Mass storage.

Send MPEG2-ts sample file to DVB-S FtA receiver:
- too big to fit on the flash : you have to download it first, using mpeg2-download.sh script or manually :
    . link : https://github.com/LamaBleu/Pluto-DATV-test/raw/master/samples/MPEG2-lalinea.ts
    . copy the file to the USB Mass Storage THEN eject the USB volume to perform a sync.
    . now you can run datv-tx-mpeg2.sh script ( will transmit on 970MHz, 1000kS/s 7/8)
    . Use only on interior, for test purposes, short antenna, at your own risk (prohibited freq).

Send DATV from shell :
 leandvbtx < /gadget/rpidatv.ts | leaniiotx -f 970000000 --bufsize 32768 --nbufs 32 --bw 1e6 -v



Receive DATV  using LeanTRX and VLC :

- Send DATV RF signal using RpiDATV :  435MHz 250 kS/s FEC 1:2
- Receive on Pluto side :
 leaniiorx --bufsize 65536 --nbufs 32 -f 435e6 -s 2e6 --bw 250e3 -v | leansdrserv --info3-httpd 8003 leandvb --s16  -f 2e6 --tune 0 --sr 250e3 --sampler rrc --rrc-rej 20 --const QPSK --standard DVB-S --cr 1/2 --fastlock -v --json --anf 0 --fd-info 3 --fd-const 3 --fd-spectrum 3 | nc -l -p 4444 192.168.2.1
- Computer side :  nc 192.168.2.1 4444 | cvlc -



Transmit DATV : 
===============


*** GNUradio sample script is provided on USB mass-storage. You have to install gr-iio bloks on your actual GRC.
This script uses rpidatv.ts video sample, and it works well for SDRangel DATV test, signal can be received on a DVB-S receiver, up to 1700 kS.


**** Send live-webcam to DATV (using RPi and avc2ts from F5OEO) : 

- video source from RPi : Picam or USB webcam
- Pluto is listening for video-TS multicast sent by RPi, running avc2ts.

On the Pi side, install avc2ts : https://github.com/F5OEO/avc2ts
Installation is simple but can take a long time ! Do not interrupt.
Do not confuse with avc2ts utility included with RPiDATV, this one is not compatible.
Still on the Pi, install mnc : https://github.com/marascio/mnc

From shell on Pi run following command to stream the Picam:
~/avc2ts/avc2ts -t 0 -m 403000 -b 300000 -x 640 -y 480 -f 10 -n 230.0.0.10:10000:0.0.0.0

Use : ~/avc2ts/avc2ts -t 3 .........  to stream USB cam.
Adapt settings !

On the pluto side, run udpwifi-rx.sh script  to transmit on 437000000 (or udpwifi-rx.sh <frequency-Hz> to change freq.)

EXPERIMENTAL : auto start at boot.

By setting "udpwifi_enable = 1" in config.txt file (eject then reboot), Pluto will run udpwifi-rx.sh script for 15 minutes on $FREQUENCY (or 437 MHz if not set through config.txt).
This script will start one minute after boot. LED1 slow blinking during the first minute then fast-blinking during DATV transmission.



This was tested using PiZero + Picam, both Pizero and Pluto powered via battery and connected via WiFi :)
We have now a 100% mobile DATV transmitter, using mobile webcam.
Once again thanks to F5OEO for suggesting this idea, and helping to debug.


OPENWEBRX
=========
Was not on my initial plan to add OpenWebRX on this firmware, but I found 2 MB to fill the flash ;) 
Really easy to implement.
Launch manually by running 'openwebrx.sh' script. 
By running 'openwebrx.sh 144500000' you will start on 144.5 MHz ... 
Frequency can be omitted, will start using the last frequency.

I DO NOT plan to make it run at boot, or in background sorry. Please install Plutoweb instead ;)




***** DEV-CORNER : ACCESS TO PLUTO DEVICE  ********



# iio_info -s
Library version: 0.16 (git tag: v0.16)
Compiled with backends: local xml ip usb serial
Available contexts:
	0: Local devices [local:]


NEW URI is local: !

status.sh script will show RX status at anytime.



From shell (on pluto):
======================

get RX gain:
cat /sys/bus/iio/devices/iio\:device1/in_voltage0_hardwaregain

get gain mode:
cat /sys/bus/iio/devices/iio\:device1/in_voltage0_gain_control_mode

get RX freq:
cat /sys/bus/iio/devices/iio\:device1/out_altvoltage0_RX_LO_frequency

Set RX gain:
cd /sys/bus/iio/devices/iio:device1
echo "58" > in_voltage0_hardwaregain


From shell again but using iio 
==============================

Change TX freq:
iio_attr -q -c ad9361-phy altvoltage1 frequency 435200000

Get/set RX freq
iio_attr -q -c ad9361-phy altvoltage0 frequency
iio_attr -q -c ad9361-phy altvoltage0 frequency 435200000

Use following commands to get more infos on device :

iio_attr -u local: -B
iio_attr -u local: -c
iio_attr -u local: -c ad9361-phy


Python
======

Python test scripts to verify iio and SoapySDR bindings are working :
-->  have a look to /root/python folder
Somes python folders are not working as is. You have to install python-numpy to the system.



- Run scripts from USB drive.

Running the pluto powered from the right USB connector, you can connect USB drive (or Wifi dongle) to
the left USB connector.


It's then possible to run scripts, and save resulting files (WAV captures, CSV files) on USB key.
It's also possible to perform update or add system files to the Pluto.

Create a script runme0.sh on external USB drive and plug it to the Pluto.
Please have a look to pages 29 to 31 of this precious doc : 
https://archive.fosdem.org/2018/schedule/event/plutosdr/attachments/slides/2503/export/events/attachments/plutosdr/slides/2503/pluto_stupid_tricks.pdf


Credits :
special thanks to unixpunk (Plutoweb firmware), F5OEO, F4DAV.


Lamableu (@fonera_cork) - 27/01/2019

