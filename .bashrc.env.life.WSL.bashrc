proxy_host=$(cat /etc/resolv.conf | awk '$1 == "nameserver" { print $2 }')
