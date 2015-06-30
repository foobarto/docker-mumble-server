FROM ubuntu:14.04

RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get -y install \
    	mumble-server \
    	pwgen \
    && rm -rf /var/lib/apt/lists/*

# Default port for mumble
EXPOSE 64738
EXPOSE 64738/udp

ENV MUMBLE_SERVER_NAME="Mumble Server"
ENV MUMBLE_MAX_USERS=10000
ENV MUMBLE_WELCOME_TEXT="Welcome!"

ADD ./mumble/mumble-server.ini /etc/mumble-server.ini
ADD ./init/murmur.init /etc/init/murmur.init
ADD ./scripts/start /start
RUN mkdir /data && \
	chown mumble-server:mumble-server /data && \
	chmod +x /start

VOLUME ["/data"]
USER mumble-server
CMD ["/start"]
