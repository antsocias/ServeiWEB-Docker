FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install apache2 -y && \
    apt-get clean

RUN mkdir -p /var/www/viralup/logs \
             /srv/www/viralup/imatges

RUN chown -R www-data:www-data /var/www/viralup \
                             /srv/www/viralup

COPY viralup.conf /etc/apache2/sites-available/viralup.conf

RUN a2dissite 000-default.conf && \
    a2ensite viralup.conf && \
    a2enmod rewrite

EXPOSE 80
CMD ["apachectl", "-D", "FOREGROUND"]
