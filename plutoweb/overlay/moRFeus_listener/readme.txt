moRFeus listener for Linux x86/x64, Raspberry Pi.
by LamaBleu 05/2018

Features :
==========

- Remote or local access to moRFeus using TCP/IP. 
  Nothing to install on client computer, except a telnet client (PuTTY or other terminal app)
  Simultaneous connections 
- Local use: launch CLI from console (no networking)
- telnet access, moRFeus HTTP status
- Send raw TCP/UDP frames to moRFeus from scripts.


- Ports usage
 7778 : TCP port for telnet access
 7779 : UDP port
 7780 : display HTTP status only.


Available commands :
====================
S : display moRFeus status
F 123456789  : set frequency to 123456789 Hz
M [x] : switch to Mixer mode, power value = x
G [x] : switch to Generator mode, power value = x
P x : set Current value to x
X or Q : disconnect
K : disconnect and KILL server

* examples : G , G 0 , M 1 , F 547854789
* lowercase/UPPERCASE accepted. errors are ignored by CLI or moRFeus
* x (to set power) can be omitted, power is kept unmodified


- Install :
===========
   git clone https://github.com/LamaBleu/moRFeus_listener
   cd moRFeus_listener
   chmod +x ./setup.sh
   ./setup.sh

Actions performed by setup.sh :
- download morfeus_tool from Outernet archives website for the right platform
- reconfigure files to the current working user/directory (instead of default user : pi)
- set permissions

For a RPi running with default user 'pi', downloading and making executable the morfeus_tools should be enough.

- Launch :
==========

** Manual launch from terminal:

- basic for local use, no network
    
    cd ~/moRFeus_listener
    sudo ./morf_cli.sh

- network daemon : 

    cd ~/moRFeus_listener
    sudo ./morf_tcp.sh &

- kill server

    sudo killall socat

    or use 'K' command from CLI
TIPS :
======

** Enable the moRFeus server at boot (replace username and path-to-directory values) :

edit /etc/rc.local file, add BEFORE 'exit 0' instruction this line :
  su username -c '/path_to_directory/morf_tcp.sh' &

ONCE AGAIN : Be careful to add this line BEFORE 'exit 0' and set correct path !



** Network

TCP : echo "M 4" | nc -q2 192.168.0.21 7778 
TCP : echo "G 3" | nc -q3 192.168.0.21 7778 >&- (nd mode: no message displayed on console)
UDP : echo "M 2" | nc -u 192.168.0.21 7779
UDP : echo "G 2" | nc -u -q1 192.168.0.21 7779 >&-  (blind mode: no message displayed on console)

Telnet : telnet 192.168.0.21 7778
another simple telnet "client" for linux: nc 192.168.0.21 7778

Get moRFeus status from shell :
get frequency : nc 192.168.0.21 7780 | grep Freq | awk '{print $3}'
get mode : nc 192.168.0.21 7780 | grep Freq | awk '{print $3}'
get power : nc 192.168.0.21 7780 | grep Power | awk '{print $3}'

- Network checking (is the server running?)
==================
sudo netstat -atupn | grep socat

display listening ports :

tcp        0      0 0.0.0.0:7780            0.0.0.0:*               LISTEN      852/socat
tcp        0      0 0.0.0.0:7778            0.0.0.0:*               LISTEN      850/socat
udp        0      0 0.0.0.0:7779            0.0.0.0:*                           851/socat


- SSH access
============

ssh username@morfeus_ip-address 'sudo /path_to_morfeus_listener/morf_cli.sh'
example :
ssh myname@192.168.0.11 'sudo /home/myname/moRFeus_listener/morf_cli.sh'
However this is not really secure :(

More secure alternative is to add a specific user (belonging to sudo group) for moRFeus device:

moRFeus:x:1001:1001::/home/moRFeus:/home/moRFeus/moRFeus_listener/morf_cli.sh

and give full rights through /etc/sudoers file:
moRFeus   ALL=NOPASSWD:  /home/moRFeus/moRFeus_listener/




