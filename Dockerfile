# Httpd with PHP
# VERSION	1.3

FROM centos:7
MAINTAINER Vuk Vasic <hasterson123@gmail.com>
ENV container docker

RUN yum update -y \
	&& yum install -y epel-release \ 
    && rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm \
	&& yum install -y \
	beanstalkd \
	httpd \
	libjpeg* \
	memcached \
	nano \
	php-pear-Net-Socket \
	php56w \
	php56w-bcmath \
	php56w-common \
	php56w-devel \
	php56w-fpm \
	php56w-gd \
	php56w-imap \
	php56w-ldap \
	php56w-mbstring \
	php56w-mcrypt \
	php56w-mysqlnd \
	php56w-pecl-memcached \
	php56w-xml \
	php56w-xmlrpc \
	python-pip \
	supervisor \
	wget \
	&& yum clean all \
	&& pip install --upgrade pip \
	&& pip install supervisor \
    && mkdir -p /etc/supervisor/conf.d \
    && wget https://gist.githubusercontent.com/mozillazg/6cbdcccbf46fe96a4edd/raw/2f5c6f5e88fc43e27b974f8a4c19088fc22b1bd5/supervisord.service -O /usr/lib/systemd/system/supervisord.service \
    && mkdir /opt/logs/ \
    && touch /opt/logs/queue_supervisord.log &&  echo "" > /var/run/supervisor/supervisor.sock


RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

COPY ./dockerfiles/etc/ /etc/

ADD ./dockerfiles/cmd.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/cmd.sh 

CMD ["/usr/local/bin/cmd.sh"]

EXPOSE 80
