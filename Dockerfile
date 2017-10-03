FROM ubuntu:latest
MAINTAINER Ryan Kurte <ryankurte@gmail.com>
LABEL Description="Docker image for OMNeT++ Network Simulator"

RUN apt-get update

# General dependencies
RUN apt-get install -y \
  git \
  wget \
  vim \
  build-essential \
  clang \
  bison \
  flex \
  perl \
  tcl-dev \
  tk-dev \
  libxml2-dev \
  zlib1g-dev \
  default-jre \
  doxygen \
  graphviz \
  libwebkitgtk-1.0-0 \
  xvfb

# QT4 components
RUN apt-get install -y \
  qt5-qmake \
  qtbase5-dev \
  openscenegraph \
  libopenscenegraph-dev \
  openscenegraph-plugin-osgearth \
  osgearth \
  osgearth-data \
  libosgearth-dev


# OMNeT++ 5

# Create working directory
RUN mkdir -p /usr/omnetpp
WORKDIR /usr/omnetpp

# Fetch Omnet++ source
# (Official mirror "doesn't support" command line downloads. Fortunately, we don't care)
RUN wget --header="Accept: text/html" \
         --user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0" \
         --referer="https://omnetpp.org" \
         --output-document=omnetpp-5.2-src.tgz \
         https://omnetpp.org/omnetpp/send/30-omnet-releases/2317-omnetpp-5-2-linux

RUN tar -xf omnetpp-5.2-src.tgz

# Compilation requires path to be set
ENV PATH $PATH:/usr/omnetpp/omnetpp-5.2/bin

# Configure and compile omnet++
RUN cd omnetpp-5.2 && \
    xvfb-run ./configure && \
    make

# Cleanup
RUN apt-get clean && \
  rm -rf /var/lib/apt && \
  rm /usr/omnetpp/omnetpp-5.2-src.tgz


