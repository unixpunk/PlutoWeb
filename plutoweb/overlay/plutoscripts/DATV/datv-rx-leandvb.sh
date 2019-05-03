echo "Receive DATV on 435MHz, SR 333kS/s, FEC 7/8"
echo "Forward TS stream to 192.168.2.1 4444 using nmux"
echo "From your computer use 'nc 192.168.2.1 4444 | cvlc -'"
echo
echo
leaniiorx --bufsize 131072 --nbufs 32 -f 435e6 -s 2e6 --bw 333e3 -v | leansdrserv --info3-httpd 8003 leandvb --s16 -f 2e6 --tune 0 --sr 333e3 --sampler rrc --rrc-rej 20 --const QPSK --standard DVB-S --cr 7/8 -v --json --anf 0 --fd-info 3 --fd-const 3 --fd-spectrum 3 | nmux -a 192.168.2.1 -p 4444 -n 64
