
FROM ubuntu:15.10
MAINTAINER Jakob Jarosch <dev@jakobjarosch.de>

RUN echo "postfix postfix/mailname string local.cloud" | debconf-set-selections
RUN echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections

RUN apt-get update && apt-get install -y postfix postfix-mysql
RUN apt-get update && apt-get install -y dovecot-imapd dovecot-pop3d dovecot-mysql
RUN apt-get update && apt-get install -y amavis clamav clamav-daemon spamassassin
RUN apt-get update && apt-get install -y supervisor

COPY ./services /services
RUN chmod -R +x ./services/*.sh
COPY ./config/supervisor.conf /supervisor.conf

# SMTP & Secure SMTP
EXPOSE 25  587

# IMAP & Secure IMAP
EXPOSE 143 993

# POP3 & Secure POP3
EXPOSE 110 995

CMD [ "supervisord", "-c", "/supervisor.conf" ]
