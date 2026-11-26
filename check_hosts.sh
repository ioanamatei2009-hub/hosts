#!/bin/bash
check_ip() {
	local name="$1"
	local ip="$2"
	local dns_server="$3"

	resolved_ip=$(nslookup "$name" "$dns_server" 2>/dev/null | awk '/^Address: / { print $2 }' | tail -n1)
	if [ -n "$resolved_ip" ] && [ "$resolved_ip" != "$ip" ]; then
        	echo "Bogus IP for $name in /etc/hosts!"
        fi
}

DNS_SERVER="8.8.8.8"

while read -r ip name_list; do
    
    [ -z "$ip" ] && continue
    case "$ip" in
        \#*) continue ;;
    esac

    
    if [ -n "$name_list" ]; then
        
        set -- $name_list
        name="$1"



        check_ip "$name" "$ip" "$DNS_SERVER"
    fi
done < /etc/hosts
echo "Modificat de Holhos Alexandru"
