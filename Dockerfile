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
  qt4-qmake \
  libqt4-dev \
  libqt4-opengl-dev \
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
# (Official mirror doesn't support command line downloads...)
#RUN wget https://drive.google.com/open?id=0B4lxSnaU1O17a1FNRHhwY0R2TVE
COPY omnetpp-5.0-src.tgz /usr/omnetpp


RUN tar -xf omnetpp-5.0-src.tgz

# Compilation requires path to be set
ENV PATH $PATH:/usr/omnetpp/omnetpp-5.0/bin

# Configure and compile omnet++
RUN cd omnetpp-5.0 && \
    xvfb-run ./configure && \
    make

# Cleanup
RUN apt-get clean && \
  rm -rf /var/lib/apt && \
  rm /usr/omnetpp/omnetpp-5.0-src.tgz


