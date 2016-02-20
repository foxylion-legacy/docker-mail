
build:
	docker build -t foxylion/mail .

run:
	docker run --rm -it --name mail --link my-mysql:mysql \
           -p 25:25 -p 587:587 -p 143:143 -p 993:993 -p 110:110 -p 995:995 \
           -e MYSQL_USER=root -e MYSQL_PASS=root -e MYSQL_DB=mail \
           -e MAIL_HOST=mail.mydomain.tld \
           foxylion/mail
