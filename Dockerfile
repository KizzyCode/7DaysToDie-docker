FROM amd64/ubuntu:latest

# Setup packages
ENV APT_PACKAGES \
	ca-certificates steamcmd telnet
RUN echo steamcmd steam/license note "" | debconf-set-selections \
	&& echo steamcmd steam/question select "I AGREE" | debconf-set-selections
RUN dpkg --add-architecture i386 \
 	&& apt-get update \
	&& apt-get upgrade --yes \
 	&& apt-get install --yes ${APT_PACKAGES}
 
# Create and become user
RUN groupadd --gid 10000 7daystodie \
	&& useradd --create-home --uid 10000 --gid 7daystodie 7daystodie
USER 7daystodie
WORKDIR /home/7daystodie

# Create mountpoints to ensure appropriate permissions
RUN mkdir /home/7daystodie/app \
	&& mkdir /home/7daystodie/data

# Create the data mount point to ensure valid permissions and copy and execute the startup script
COPY start.sh /usr/libexec/7daystodie-server.sh
CMD [ "/usr/libexec/7daystodie-server.sh" ]
