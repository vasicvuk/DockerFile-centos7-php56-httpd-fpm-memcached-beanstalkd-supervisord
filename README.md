# Dockerfile - Httpd, PHP 5.6, PHP-FPM, Memcached, Beanstalkd, Supervisord

This dockerfile builds a container based on CentOS 7 it includes:
  - Httpd - as server
  - PHP 5.6.30
  - PHP-FPM
  - Memcached for memory caching with PHP driver
  - Beanstalkd for Queue system
  - Supervisord for running PHP services in background

# Ideal for Laravel/Lumen projects with advanced features such as caching and queuing.

# Build
```
docker build --rm -t centos/fullphp .
```
# Run
Use **-v** to map a directory into /var/www/html of container. To be able to use Systemd inside Centos container use --privileged and set envriovment variable container to docker. To map Http port user **-p**. Example:
```
docker run -d --privileged -e "container=docker" --name demofullphp -p 8081:80 -v /private/var/www/skn:/var/www/html centos/fullphp 
```

# Get into bash
```
docket exec -it demofullphp bash
```

# Configuration
All configuration files are placed into **dockerfiles/etc/** folder. This folder is copied to container /etc/ folder. Here you can configure Httpd, PHP-FPM, Supervisord and more. File **cmd.sh** inside **dockerfiles** directory is in charge of starting services enabling SystemD calls. 