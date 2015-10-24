FROM ubuntu:14.04
MAINTAINER Bartosz Ptaszynski <foobarto@gmail.com>

# Default port for mumble
EXPOSE 64738 64738/udp
ENV VERSION "1.2.10"

ADD ./scripts/start /usr/local/bin/mumble-start
RUN apt-get update && \
		apt-get -y install \
    	pwgen \
    	wget && \
    rm -rf /var/lib/apt/lists/* && \
		mkdir /data && \
		wget https://github.com/mumble-voip/mumble/releases/download/$VERSION/murmur-static_x86-$VERSION.tar.bz2 && \
    tar xvf murmur-static_x86-$VERSION.tar.bz2 && \
    cp murmur-static_x86-$VERSION/murmur.x86 /usr/local/bin/murmurd && \
		useradd mumble-server && \
		chown mumble-server /data && \
		chmod +x /usr/local/bin/mumble-start

USER mumble-server

ADD ./mumble/mumble-server.ini /data/mumble-server.ini
ADD ./init/murmur.init /etc/init/murmur.init

VOLUME ["/data"]

CMD ["/usr/local/bin/mumble-start"]
