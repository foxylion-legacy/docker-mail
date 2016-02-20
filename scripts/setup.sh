#!/bin/bash
set -e

echo "> Configuring hostname for amavis..."
cat <<EOF > /etc/amavis/conf.d/05-node_id
use strict;
\$myhostname = "$MAIL_HOST";
EOF

echo "> Configuring hostname for postfix..."
sed -i -e "s/\${MAIL_HOST}/$MAIL_HOST/g" /etc/postfix/main.cf

echo "> Creating database..."
mysql --host=$MYSQL_HOST --user=$MYSQL_USER --password=$MYSQL_PASS -e "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DB\`;"
# Execute SQL file only when database not already populated.
if [[ "$(mysql --host=$MYSQL_HOST --user=$MYSQL_USER --password=$MYSQL_PASS $MYSQL_DB -e "SHOW TABLES LIKE 'admin';")" == "" ]]; then
  mysql --host=$MYSQL_HOST --user=$MYSQL_USER --password=$MYSQL_PASS $MYSQL_DB < /scripts/database.sql
fi
