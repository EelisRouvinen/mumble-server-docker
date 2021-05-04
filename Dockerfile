FROM ubuntu:latest
RUN apt update; apt install software-properties-common -y; add-apt-repository ppa:mumble/release; apt update; apt install mumble-server -y
EXPOSE 64738/udp
EXPOSE 64738/tcp
WORKDIR data
COPY ./mumble-server.ini /data
CMD /usr/sbin/murmurd -fg -ini /data/mumble-server.ini
