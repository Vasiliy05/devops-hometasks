FROM debian:latest
RUN apt update -y && \
    apt install -y apache2 php
ADD https://raw.githubusercontent.com/Vasiliy05/devops-hometasks/master/task-09/index.php /var/www/html/
RUN chmod 755 /var/www/html/index.php && \
    rm -f /var/www/html/index.html
EXPOSE 80
CMD apachectl -D FOREGROUND