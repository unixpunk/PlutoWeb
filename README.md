# PlutoSDR Projects

If you don't want to flash these images to test, tar up the overlay folder from either dump1090 or SoapyRemote, scp tarball root@pluto.local:./ then ssh root@pluto.local cd / && tar xf root/tarball && ls /bin.  (OpenwebRx requires python which is not in the default fw so this will not work without using the image or building your own with python (2.7) on it already.  I also use 'screen' in the startup script because its touchy about tty's not being touched while running.)

Create new issues with suggestions for other software to package into images for the PlutoSDR and I'll see what I can do.

# Features
dump1090 auto start
<BR>SoapyRemote image works both normally via USB and remotely via OTG Ethernet/Wifi
<BR>OpenwebRx supports persistent settings - change them via SSH

# TO-DO
--Web interface to control and run most/all of these SDR tools on a single image
<BR>--sdrdaemon as a POC - had issues cross-compiling csdr for neon even after tricking cmake into thinking I was neon - ON-HOLD for now.
