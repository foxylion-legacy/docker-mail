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

echo "> Configuring hostname for amavis..."
cat <<EOF > /etc/amavis/conf.d/05-node_id
use strict;
\$myhostname = "$MAIL_HOST";
EOF

echo "> Starting supervisor..."
supervisord -c /supervisor.conf
