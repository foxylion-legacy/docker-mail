#!/bin/bash
set -e

mkdir -p /var/run/clamav
chown -R clamav /var/run/clamav

while [ ! -f /var/lib/clamav/main.cvd ]
do
  echo "Anti virus database not yet initialized, waiting..."
  sleep 2
done

/usr/sbin/clamd
