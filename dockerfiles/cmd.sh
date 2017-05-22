#!/bin/bash

# Do some stuffs
systemctl start supervisord
systemctl enable supervisord
systemctl start httpd
systemctl enable httpd
systemctl start beanstalkd
systemctl enable beanstalkd
systemctl start memcached
systemctl enable memcached
systemctl start php-fpm
systemctl enable php-fpm


exec /usr/sbin/init # To correctly start D-Bus thanks to https://forums.docker.com/t/any-simple-and-safe-way-to-start-services-on-centos7-systemd/5695/8

