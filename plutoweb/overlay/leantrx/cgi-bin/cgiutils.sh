# This file is part of LeanTRX (c) <pabr@pabr.org>.
# See the toplevel README for more information.

case "$(uname -m)" in
    armv7l) PATH=$PATH:../bin/armv7l:../bin/armv6l ;;
    armv6l) PATH=$PATH:../bin/armv6l ;;
    *)      PATH=$PATH:../bin/$(uname -m) ;;
esac

RECORDINGS=../html/recordings

parse_query_string() {
    local IFS="&"
    for nameval in $QUERY_STRING; do
	IFS="="
	# Whitelist safe characters here
        name=$(echo "$nameval" | sed -e 's/^\([a-zA-Z0-9_]*\)=.*$/\1/;t;d')
        val=$(echo "$nameval" | sed -e 's/^.*=\([a-zA-Z0-9():,._/-]*\)$/\1/;t;d')
	eval param_$name="\"$val\""
    done
}

killprocs() {
    killall -9 leaniiorx leaniiotx leansdrserv leandvb leanmlmrx cat 2> /dev/null
}

flagparam() {
    if [ "$1" = "on" ]; then echo $2; fi
}
