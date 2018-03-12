# PlutoSDR Projects
Use plutoweb image for most flexibility going forward.  All other single-program images moved to legacy.

If you don't want to flash these images to test, tar up the overlay folder from dump1090 or SoapyRemote, scp tarball root@pluto.local:./ then ssh root@pluto.local cd / && tar xf root/tarball && ls /bin.

Create new issues with suggestions for other software to package into images for the PlutoSDR and I'll see what I can do.

# Features
New plutoweb image combines all the other images into one with the ability to select which program to auto-start at boot
<BR>SoapyRemote image automatically allows both normal PlutoSDR via USB and remotely via OTG Ethernet/Wifi
<BR>OpenwebRx supports persistent settings - change them via SSH settings.sh command

# Fixes
Added auto-reboot every 24 hours to overcome an issue where the OTG USB seems to lose power until its unplugged/plugged back in or the Pluto is rebooted

# TO-DO
--Web interface to control and run most/all of these SDR tools on a single image
<BR>--Patch the other version of dump1090 for the pluto radio so we get the added features and better webUI
<BR>--sdrdaemon as a POC - had issues cross-compiling cm256cc for neon even after tricking cmake into thinking I was neon - ON-HOLD for now.
