FROM ubuntu:14.04

RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get -y install \
    	pwgen \
        wget \
    && rm -rf /var/lib/apt/lists/*

# Default port for mumble
EXPOSE 64738 64738/udp

RUN mkdir /data 
VOLUME ["/data"]

RUN wget https://github.com/mumble-voip/mumble/releases/download/1.2.9/murmur-static_x86-1.2.9.tar.bz2 && \
    tar xvf murmur-static_x86-1.2.9.tar.bz2 && \
    cp murmur-static_x86-1.2.9/murmur.x86 /usr/sbin/murmurd

ADD ./mumble/mumble-server.ini /etc/mumble-server.ini
ADD ./init/murmur.init /etc/init/murmur.init
ADD ./scripts/start /start

CMD ["/start"]
