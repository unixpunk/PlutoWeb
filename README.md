# PlutoSDR

Flash the pluto image and wait for it to boot and then reboot again.  This is the script checking if dual-core mode is enabled.  If its not, then it enables it and reboots.

OpenwebRx now starts automatically at boot.  My working test case is using an OTG NIC on the 'USB' port and 1a or larger power adapter on the 'power' port.  It uses DHCP, normally you can just use http://pluto.local:18075 and it will just work, even if your PC is connected to the 'USB' port, though I haven't tested this.

<H1>TO-DO</h1>
...
