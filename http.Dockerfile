## Seleccionam la imatge base
FROM ubuntu:24.04

# Evitem interaccions manuals durant la instal·lació
ENV DEBIAN_FRONTEND=noninteractive

# Actualitzam, instal·lam Apache2 i netejam els paquets descarregats
RUN apt-get update -y && \
    apt-get install apache2 -y && \
    apt-get clean

# Copiam el nostre arxiu de configuració al directori sites-available d'Apache
COPY viralupcom.conf /etc/apache2/sites-available/viralupcom.conf

# Creem la carpeta on anirà la web i donam els permisos a l'usuari d'Apache (www-data)
RUN mkdir -p /var/www/viralupcom && \
    chown -R www-data:www-data /var/www/viralupcom

# Desactivam el lloc web per defecte i activam el nostre
RUN a2dissite 000-default.conf && \
    a2ensite viralupcom.conf

# Exposam el port 80 (HTTP)
EXPOSE 80/tcp

# Comanda principal per arrencar Apache en primer pla
CMD ["apachectl", "-D", "FOREGROUND"]