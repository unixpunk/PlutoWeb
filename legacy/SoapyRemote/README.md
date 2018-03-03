# SoapyRemote

Flash the pluto image and wait for it to boot and then reboot again.  This is the script enabling dual-core mode and the 70-6000mhz mod and rebooting.  It will only happen once after each flash.

This image also happens to function as a normal PlutoSDR when plugged into USB like normal, so this is like adding remote support.  Enjoy.

SoapyRemote starts automatically at boot.  My working test case is using an OTG NIC on the 'USB' port and 1a or larger power adapter on the 'power' port.  It uses DHCP.

Make sure you have SoapySDR and SoapyRemote installed locally as well as a SDR app that supports SoapySDR.  I tested with CubicSDR and I'm able to get up to 3msps as usable audio, gets choppy but can still understand clearly.  It should automatically be detected.
