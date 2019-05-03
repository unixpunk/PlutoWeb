echo "Sending MPEG2-lalinea.ts : 970MHz 1000kS/s FEC:7/8"
if [ ! -f /gadget/config.txt ]; then
	losetup /dev/loop7 /opt/vfat.img -o 512
	mount /dev/loop7 /gadget
fi
if [ ! -f /gadget/MPEG2-lalinea.ts ]; then
	wget https://github.com/LamaBleu/Pluto-DATV-test/raw/master/samples/MPEG2-lalinea.ts -O /gadget/MPEG2-lalinea.ts
fi
leandvbtx --cr 7/8  --s16 < /gadget/MPEG2-lalinea.ts    | leaniiotx -f 970000000 --bufsize 32768 --nbufs  32 --bw 3e6 -s 1.6e6 -v
