#!/bin/bash

check_ip_host() {
    local hostname=$1
    local ip=$2
    local dns_server=$3

        if [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo "Valid IP format: $ip"
    else
        echo "Invalid IP format: $ip"
        return 1
    fi

        resolved_ip=$(dig +short "$hostname" @"$dns_server")
    if [[ $resolved_ip == "$ip" ]]; then
        echo "Hostname $hostname și IP $ip sunt corect asociate."
    else
        echo "Asociere greșită pentru $hostname și $ip."
    fi
}

while read -r line; do
    ip=$(echo "$line" | awk '{print $1}')
    hostname=$(echo "$line" | awk '{print $2}')
    check_ip_host "$hostname" "$ip" "8.8.8.8"
done < /etc/hosts
