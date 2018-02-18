# PlutoSDR

Flash the pluto image and scp tools.tar into /root

ssh root@pluto.local (pw:analog)
<BR>
cd /
<BR>
tar xf root/tools.tar
<BR>
openwebrx.sh

Point your browser to http://pluto.local:18075

<H1>TO-DO</h1>
Add curl binary to image
<BR>Figure out how to overlay the tools folder on the image so tools.tar isn't needed anymore
