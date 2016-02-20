#!/bin/bash
set -e

trap "{ echo Recieved TERM signal, stopping postfix...; /usr/sbin/postfix stop; exit 0; }" EXIT

/usr/sbin/postfix -c /etc/postfix start
echo "Postfix is now running, waiting for TERM signal..."
sleep infinity
