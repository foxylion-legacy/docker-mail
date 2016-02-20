#!/bin/bash
set -e

echo ">> Running foxylion/mail..."

if [[ "$1" == "bash" ]]; then
  echo "> Starting bash..."
  /bin/bash
  exit 0
fi

echo "> Environment variables:"
echo "MAIL_HOST=$MAIL_HOST"

/scripts/setup.sh

echo "> Starting supervisor..."
supervisord -c /supervisor.conf
