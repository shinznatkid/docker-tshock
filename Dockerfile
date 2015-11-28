# Dockerfile for a TShock Terraria Server
# https://github.com/rfvgyhn/docker-tshock
FROM mono:4.0.1
MAINTAINER Ryan Campbell <campbellr@gmail.com>

# Install unzip package
RUN apt-get -qq update && \
    apt-get -qqy install unzip

# Download and setup TShock
RUN curl -sL https://github.com/NyxStudios/TShock/releases/download/v4.3.11/tshock_release.zip > /tmp/tshock_release.zip && \
    unzip /tmp/tshock_release.zip -d /opt/tshock

COPY config.json /opt/tshock/tshock/config.json


# Start the server and expose the port
EXPOSE 7777 7878
WORKDIR /opt/tshock
ENTRYPOINT ["mono", "--server", "--gc=boehm", "TerrariaServer.exe"]
CMD ["-world", "Terraria/Worlds/Default.wld", "-autocreate", "2"]
