# dump1090

Flash the pluto image and wait for it to boot.

dump1090 starts automatically at boot.  My working test case is using an OTG NIC on the 'USB' port and 1a or larger power adapter on the 'power' port.  It uses DHCP, normally you can just use http://pluto.local:8080 and it will just work, even if your PC is connected to the 'USB' port, though I haven't tested this.

This isn't the feature-rich fork of dump1090, so its mostly useful as a standalone ADS-B map, not much in the way of external integration available.

Can temporarily change options: ssh root@pluto.local "/etc/init.d/S95dump1090 stop && vi /bin/dump1090.sh && /etc/init.d/S95dump1090 start"
