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

# TODO: clean these ENVs up
ENV MUMBLE_ARCHIVE=murmur-static_x86-1.2.9.tar.bz2
ENV MUMBLE_DOWNLOAD_URL=https://github.com/mumble-voip/mumble/releases/download/1.2.9/murmur-static_x86-1.2.9.tar.bz2
ENV MUMBLE_EXE=murmur-static_x86-1.2.9/murmur.x86

RUN wget ${MUMBLE_DOWNLOAD_URL} && \
    tar xvf ${MUMBLE_ARCHIVE} && \
    cp ${MUMBLE_EXE} /usr/sbin/murmurd

ADD ./mumble/mumble-server.ini /etc/mumble-server.ini
ADD ./init/murmur.init /etc/init/murmur.init
ADD ./scripts/start /start

CMD ["/start"]
