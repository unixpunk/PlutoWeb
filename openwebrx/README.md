# OpenwebRx

Flash the pluto image and wait for it to boot and then reboot again.  This is the script enabling dual-core mode and the 70-6000mhz mod and rebooting.  It will only happen once after each flash.

OpenwebRx now starts automatically at boot.  My working test case is using an OTG NIC on the 'USB' port and 1a or larger power adapter on the 'power' port.  It uses DHCP, normally you can just use http://pluto.local:8073 and it will just work, even if your PC is connected to the 'USB' port, though I haven't tested this.

The only way to change freq, sample rate, etc is to ssh root@pluto.local "/etc/init.d/S95openwebrx stop && vi /openwebrx/config-openwebrx.py && /etc/init.d/S95openwebrx start".  That's only temporary though.  Would be cool to know if we could use fw_setenv to save things like that for persistence across reboots without having to edit the overlay and rebuild your own image...
