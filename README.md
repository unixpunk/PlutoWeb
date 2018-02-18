# PlutoSDR

The image and tools.tar are needed to run openwebrx on the PlutoSDR.

Flash the pluto image and upload tools.tar to /root. (I will add curl to the image later...)

ssh root@pluto.local (pw:analog)
<BR>
cd /
<BR>
tar xf root/tools.tar
<BR>
openwebrx

Point your browser to http://pluto.local:18075

<H1>TO-DO</h1>
Add curl binary to image
<BR>Figure out how to overlay the tools folder on the image so tools.tar isn't needed anymore
