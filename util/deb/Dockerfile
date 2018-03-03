FROM debian
MAINTAINER Olof Hagsand <olof@hagsand.se>
ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    make \
    gcc \
    automake \
    flex \
    bison \
    libcurl4-openssl-dev

# Create the directory which we will install files to
RUN mkdir -p /grideye-agent/usr/

# Clone all dependencies
RUN git clone https://github.com/olofhagsand/cligen.git
RUN git clone https://github.com/clicon/clixon.git
RUN git clone https://github.com/olofhagsand/grideye_agent.git

# Change workdir and build cligen
WORKDIR /cligen
RUN ./configure --prefix=/grideye-agent/usr/
RUN make
RUN make install
RUN cp -r /grideye-agent/usr/ /

# Change workdir and build clixon
WORKDIR /clixon
RUN ./configure --without-restconf --without-keyvalue --prefix=/grideye-agent/usr/
RUN make
RUN make install
RUN make install-include
RUN cp -r /grideye-agent/usr/ /

# Change workdir and build grideye agent
WORKDIR /grideye_agent
RUN ./configure --prefix=/grideye-agent/usr/
RUN make
RUN make install

# Build the package
WORKDIR /
RUN mkdir /grideye-agent/DEBIAN/
COPY control /grideye-agent/DEBIAN/
COPY extract_version.sh /
RUN sh /extract_version.sh
RUN cat /grideye-agent/DEBIAN/control
RUN dpkg-deb --build /grideye-agent
