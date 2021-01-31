FROM haugene/transmission-openvpn

ENV BEETSDIR=/beets
ENV TRANSMISSION_SCRIPT_TORRENT_DONE_FILENAME=/sort.sh

COPY beets.yaml /beets/config.yaml
COPY mnamer.json /mnamer/mnamer-v2.json
COPY sort.sh /sort.sh

RUN apk add --no-cache python3 su-exec && python3 -m ensurepip && python3 -m pip install --upgrade pip &&\
	pip3 install wheel &&\
	pip3 install requests &&\
	pip3 install mnamer &&\
	pip3 install https://github.com/beetbox/beets/tarball/master &&\
	chmod +x /sort.sh &&\
	mkdir -p /media-storage/Movies &&\
	mkdir -p /media-storage/Music &&\
	mkdir -p /media-storage/TV
