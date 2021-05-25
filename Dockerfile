FROM ubuntu:latest
# gnupg is used for authenticated apt repositories
RUN apt update; apt install gnupg -y
RUN echo "deb http://ppa.launchpad.net/mumble/release/ubuntu focal main" > /etc/apt/sources.list.d/mumble-server.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 22C54CD5AAE0971730875E0285DECED27F05CF9E
RUN apt update; apt install mumble-server -y

# open default mumble port
EXPOSE 64738/udp
EXPOSE 64738/tcp

# set user
RUN groupadd -g 2000 mumble; useradd -m -u 2001 -g mumble mumble
# set file permission
WORKDIR /data
COPY ./mumble-server.ini /data
RUN chown mumble:mumble /data/mumble-server.ini
RUN chown -R mumble:mumble /var/lib/mumble-server/ /var/log/mumble-server/ 

# set user
USER mumble
CMD /usr/sbin/murmurd -fg -ini /data/mumble-server.ini
