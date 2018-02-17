# PlutoSDR

The image and tools.tar are needed to run openwebrx on the PlutoSDR.

Flash the image and upload tools.tar to /root. (I will add curl to the image)

ssh root@pluto.local (pw:analog)
<BR>
cd /
<BR>
tar xf root/tools.tar
<BR>
openwebrx

Point your browser to http://pluto.local:18075
