#/bin/sh
cd /home/steve/Desktop/SDR/Pluto/PlutoWeb/plutoweb/overlay
rm -f ../update.zip*
zip -roy ../update.zip *
cd ..
md5sum -b update.zip >update.zip.md5sum
