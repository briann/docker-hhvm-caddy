FROM ubuntu:16.04

RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449

# TODO: Specify version of hhvm
RUN apt-get update -y \
 && apt-get install -y software-properties-common \
 && add-apt-repository "deb http://dl.hhvm.com/ubuntu xenial main" \
 && apt-get update -y \
 && apt-get install -y hhvm curl supervisor \
 && apt-get clean
RUN curl https://getcaddy.com | bash

# Environment
RUN mkdir -p /var/www/public
RUN mkdir -p /opt/caddy

# Configs
ADD ./configs/Caddyfile /opt/caddy/Caddyfile
ADD ./configs/php.ini /etc/hhvm/php.ini
ADD ./configs/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Run
EXPOSE 80
CMD ["/usr/bin/supervisord"]