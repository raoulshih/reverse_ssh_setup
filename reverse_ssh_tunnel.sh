#!/bin/sh
# ------------------------------
# Added by setup_reverse_tunnel.sh
# ------------------------------
# See autossh and google for reverse ssh tunnels to see how this works

# When this script runs it will allow you to ssh into this machine even if it is behind a firewall or has a NAT'd IP address. 
# From any ssh capable machine you just type ssh -p 15330 pi@raoulberry.no-ip.info

# Not executing when lo (loop back) interface is up


if [ "$IFACE" = lo  || "$IFACE" = "--all"]; then
	exit 0
fi

if [ "$MODE" != start ]; then
	exit 0
fi

if pgrep "autossh" > /dev/null
then
	exit 0
fi

# This is the username on your local server who has public key authentication setup at the middleman
USER_TO_SSH_IN_AS=root

# This is the username and hostname/IP address for the middleman (internet accessible server)
MIDDLEMAN_SERVER_AND_USERNAME=root@someserver

# Port that the middleman will listen on (use this value as the -p argument when sshing)
PORT_MIDDLEMAN_WILL_LISTEN_ON=3333

# Connection monitoring port, don't need to know this one
AUTOSSH_PORT=20285

# Ensures that autossh keeps trying to connect
AUTOSSH_GATETIME=0
ssh-keyscan -p 3456 -H 192.168.11.13 >  /home/pi/.ssh/known_hosts
su -c "autossh -f -N -i /home/pi/.ssh/id_rsa -R ${PORT_MIDDLEMAN_WILL_LISTEN_ON}:localhost:22 -p 8888 ${MIDDLEMAN_SERVER_AND_USERNAME} -oLogLevel=error  -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no" pi
