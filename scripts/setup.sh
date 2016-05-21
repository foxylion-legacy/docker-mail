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
MYSQL_PWD=$MYSQL_PASS mysql --host=$MYSQL_HOST --user=$MYSQL_USER -e "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DB\`;"
# Execute SQL file only when database not already populated.
if [[ "$(MYSQL_PWD=$MYSQL_PASS mysql --host=$MYSQL_HOST --user=$MYSQL_USER $MYSQL_DB -e "SHOW TABLES LIKE 'admin';")" == "" ]]; then
  MYSQL_PWD=$MYSQL_PASS mysql --host=$MYSQL_HOST --user=$MYSQL_USER $MYSQL_DB < /scripts/database.sql
fi
