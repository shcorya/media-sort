FROM haugene/transmission-openvpn

ENV BEETSDIR=/beets
ENV TRANSMISSION_SCRIPT_TORRENT_DONE_FILENAME=/sort.sh

COPY beets.yaml /beets/config.yaml
COPY mnamer.json /mnamer/mnamer-v2.json
COPY sort.sh /sort.sh

RUN apk add --no-cache python3 && python3 -m ensurepip && python3 -m pip install --upgrade pip &&\
	pip3 install wheel &&\
	pip3 install requests &&\
	pip3 install mnamer &&\
	pip3 install https://github.com/beetbox/beets/tarball/master &&\
	chmod +x /sort.sh &&\
	mkdir -p /media/Movies &&\
	mkdir -p /media/Music &&\
	mkdir -p /media/TV &&\
	chown -R 33:33 /media
