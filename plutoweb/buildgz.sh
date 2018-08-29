#/bin/sh

cd overlay
rm -f ../update.tgz*
tar -czvf ../update.tgz *
cd ..
md5sum -b update.tgz >update.tgz.md5sum
