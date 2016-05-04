FROM debian:jessie
MAINTAINER watsy0007 <watsy0007@gmail.com>

# Install Debian and base software.
RUN \
  echo "deb http://mirrors.163.com/debian/ jessie main non-free contrib" > /etc/apt/sources.list \
  echo "deb http://mirrors.163.com/debian/ jessie-updates main non-free contrib" >> /etc/apt/sources.list \
  echo "deb http://mirrors.163.com/debian/ jessie-backports main non-free contrib" >> /etc/apt/sources.list \
  echo "deb-src http://mirrors.163.com/debian/ jessie main non-free contrib" >> /etc/apt/sources.list \
  echo "deb-src http://mirrors.163.com/debian/ jessie-updates main non-free contrib" >> /etc/apt/sources.list \
  echo "deb-src http://mirrors.163.com/debian/ jessie-backports main non-free contrib" >> /etc/apt/sources.list \
  echo "deb http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib" >> /etc/apt/sources.list \
  echo "deb-src http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib" >> /etc/apt/sources.list \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y git wget build-essential zlib1g-dev libpcre3-dev git gcc g++ make && \
  rm -rf /var/lib/apt/lists/*

# Get Source Code
RUN \
  wget "http://nginx.org/download/nginx-1.7.8.tar.gz" && \
  wget "http://linux.stanford.edu/pub/exim/pcre/pcre-8.36.tar.gz" && \
  wget "https://www.openssl.org/source/openssl-1.0.1j.tar.gz" && \
  wget "http://zlib.net/zlib-1.2.8.tar.gz" && \
  git clone https://github.com/cuber/ngx_http_google_filter_module && \
  git clone https://github.com/yaoweibin/ngx_http_substitutions_filter_module && \
  tar xzvf nginx-1.7.8.tar.gz && \
  tar xzvf pcre-8.36.tar.gz && \
  tar xzvf openssl-1.0.1j.tar.gz && \
  tar xzvf zlib-1.2.8.tar.gz

# Install Nginx
RUN \
  cd nginx-1.7.8 && \
  ./configure --prefix=/opt/nginx-1.7.8 --with-pcre=../pcre-8.36 --with-openssl=../openssl-1.0.1j --with-zlib=../zlib-1.2.8 --with-http_ssl_module --add-module=../ngx_http_google_filter_module --add-module=../ngx_http_substitutions_filter_module && \
  make && \
  make install

# Run Nginx
ADD ./nginx.conf /opt/nginx-1.7.8/conf/nginx.conf

EXPOSE 80
EXPOSE 443

WORKDIR /opt/nginx-1.7.8/sbin

CMD ["./nginx", "-g", "daemon off;"]
