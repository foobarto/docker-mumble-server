Installs Mumble (Murmur) server v1.2.10 and exposes both TCP and UDP ports.
Persists the database and configuration files in the exposed /data VOLUME.

Example how to run:

		docker run -d --restart=always -p 64738:64738 -p 64738:64738/udp --name=mumble foobarto/docker-mumble-server:1.2.10
