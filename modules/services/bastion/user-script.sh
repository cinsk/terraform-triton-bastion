#!/bin/bash

kernel=$(uname -s)

exec >& /var/log/terraform.provision.log

log() {
    echo "$(date -Iseconds) $*"
}

if [ "$kernel" = "SunOS" ]; then
    pkgin update
    pkgin upgrade
    pkgin -y install tmux
    exit 0
fi


if [ "$kernel" != "Linux" ]; then
    log "error: unrecognized kernel($kernel) detected"
    exit 1
fi
   
if [ -f /etc/centos-release ]; then
    yum -y update
    yum -y install tmux screen nmap-ncat
    exit 0
fi

log "error: unrecognized Linux distro: $(uname -a)"
