# OpenWebRX

Flash the pluto image and wait for it to boot and then reboot again.  This is the script enabling dual-core mode and the 70-6000mhz mod and rebooting.  It will only happen once after each flash.

OpenWebRX now starts automatically at boot.  My working test case is using an OTG NIC on the 'USB' port and 1a or larger power adapter on the 'power' port.  It uses DHCP, normally you can just use http://pluto.local:8073 and it will just work, even if your PC is connected to the 'USB' port and not a OTG NIC.

*** We can now persist settings across reboots if you don't like my default Chicago PD range.  ssh root@pluto.local and run either temp-settings.sh or settings.sh.  The former will not write to nvram, just update via file and restart OpenWebRX.  Once you have settings you like, then use settings.sh to set them permanently.
