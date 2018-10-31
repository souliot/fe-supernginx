FROM centos:7 AS build
MAINTAINER BossLin <linleizhou1991024@163.com>

#get all the dependences
RUN yum install -y pcre-devel make gcc gcc-c++ ncurses-devel zlib zlib-devel openssl openssl-devel perl

ENV NGINX_VER=1.15.5 \
    WORK_PATH=/usr/local/software
  

ADD nginx-${NGINX_VER}.tar.gz ${WORK_PATH}/

#create the dirs to store the files downloaded from internet

WORKDIR ${WORK_PATH}/nginx-${NGINX_VER}

RUN ./configure --prefix=/usr/local/nginx \ 
 --with-http_ssl_module \ 
 --with-http_stub_status_module \ 
 --user=root \ 
 --group=root \
 && make \
 && make install

FROM centos:7
LABEL maintainer "linleizhou19910924@163.com"

COPY --from=build /usr/local/nginx  /usr/local/nginx

RUN yum install -y epel-release \
  && yum install -y supervisor 

ADD start.sh /usr/bin/

#make the start.sh executable 
RUN chmod 777 /usr/bin/start.sh 

ENTRYPOINT ["/usr/bin/start.sh"]
