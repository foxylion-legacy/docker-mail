# Email services as a docker container

The ``foxylion/mail`` container provides all important mail services to serve
emails from your server. It includes ``postfix``, ``dovecot``, ``amavis``,
``clamav``, ``spamassassin`` and ``postfixadmin``.

![Logo](docker-mail-logo.png)

## Start the container

You'll need [``docker-engine``](https://docs.docker.com/engine/installation/)
to be installed on your server. Furthermore you need a MySQL container running
for the email address configuration. Details about running a MySQL container
can be found [here](https://hub.docker.com/_/mysql/).

```bash
docker run -d --name mail --link your-mysql:mysql \
           -p 25:25 -p 587:587 -p 143:143 -p 993:993 -p 110:110 -p 995:995 \
           -e MYSQL_USER=root -e MYSQL_PASS=root -e MYSQL_DB=mail \
           -e MAIL_HOST=mail.mydomain.tld \
           foxylion/mail
```
