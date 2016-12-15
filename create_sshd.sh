#/bin/bash

if [ $# -ne 3 ]  ; then
    echo "usage: create_ssh.sh client_name client_port ssh_root_password"
else
    export CLIENT_ID=$1
    export PUBLIC_HOST_PORT=$2
    export SSH_ROOT_PASSWORD=$3
    echo "Prepare to create ssh container CLIENT_ID={$CLIENT_ID}, HOST_PORT={$PUBLIC_HOST_PORT}, SSH_ROOT_PASS={$SSH_ROOT_PASSWORD}"
    docker-compose up reversesshpublic
fi

