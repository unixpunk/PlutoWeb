if [ ! -f /gadget/config.txt ]; then
	losetup /dev/loop7 /opt/vfat.img -o 512
	mount /dev/loop7 /gadget
fi
wget https://github.com/LamaBleu/Pluto-DATV-test/raw/master/samples/MPEG4-rpidatv.ts -o /gadget/rpidatv.ts

