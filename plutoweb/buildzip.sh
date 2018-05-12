#/bin/sh
cd overlay
rm -f ../update.zip*
zip -roy ../update.zip *
cd ..
md5sum -b update.zip >update.zip.md5sum
