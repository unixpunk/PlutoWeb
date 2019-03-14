#!/bin/sh
killall socat >/dev/null 2>&1


morf_tool_dir=/moRFeus_listener

## TCP Listener

socat TCP4-LISTEN:7778,fork,crlf,reuseaddr EXEC:$morf_tool_dir/morf_cli.sh,pty,stderr,echo=0 &

### EXAMPLES:
### telnet 192.168.0.21 7778
### echo "M 6" > /dev/tcp/192.168.0.21/7778
### echo "G" | nc 192.168.0.21 7778
### nc 192.168.0.21 7778



### UDP Listener

socat UDP-l:7779,fork,reuseaddr EXEC:$morf_tool_dir/morf_cli.sh &

### EXAMPLE:
### echo "M 1" | nc -u -q3 192.168.0.21 7779




### HTTP Listener

socat TCP-LISTEN:7780,crlf,reuseaddr,fork SYSTEM:"echo 'HTTP/1.0 200'; echo 'Cache-Control\: no-cache'; echo 'Contentype\: text/plain'; $morf_tool_dir/get_status.http"

### EXAMPLE:
### http://192.168.0.21:7780


