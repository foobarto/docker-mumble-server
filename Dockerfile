FROM ubuntu:14.04

RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get -y install \
    	mumble-server \
    	pwgen \
    && rm -rf /var/lib/apt/lists/*

# Default port for mumble
EXPOSE 64738 64738/udp

RUN mkdir /data 
VOLUME ["/data"]
ADD ./mumble/mumble-server.ini /etc/mumble-server.ini
ADD ./init/murmur.init /etc/init/murmur.init
ADD ./scripts/start /start

CMD ["/start"]
