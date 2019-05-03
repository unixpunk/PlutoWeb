if [ ! -f /gadget/config.txt ]; then
	losetup /dev/loop7 /opt/vfat.img -o 512
	mount /dev/loop7 /gadget
fi
wget https://github.com/LamaBleu/Pluto-DATV-test/raw/master/samples/MPEG2-lalinea.ts -o /gadget/MPEG2-lalinea.ts

