FROM ubuntu:latest
MAINTAINER Ryan Kurte <ryankurte@gmail.com>
LABEL Description="Docker image for Castalia and OMNeT++ Network Simulators"

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
  libwebkitgtk-1.0-0

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
RUN wget https://omnetpp.org/omnetpp/send/30-omnet-releases/2305-omnetpp-50-linux

RUN tar -xf omnetpp-5.0-linux.tgz && \
  cd omnetpp-5.0 && \
  . setenv && \
  ./configure WITH_TKENV=no && \
  make && \
  make install

# Cleanup
RUN apt-get clean && \
  rm -rf /var/lib/apt

