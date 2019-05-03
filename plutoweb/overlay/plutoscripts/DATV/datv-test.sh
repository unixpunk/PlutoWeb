if [ ! -f /gadget/config.txt ]; then
	losetup /dev/loop7 /opt/vfat.img -o 512
	mount /dev/loop7 /gadget
fi
leandvbtx --cr 1/2  --s16 < /gadget/rpidatv.ts    | leaniiotx -f 435000000 --bufsize 32768 --nbufs  32 --bw 3e6 -s 1e6 -v
