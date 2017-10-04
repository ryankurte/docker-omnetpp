# docker-omnetpp

A Docker container for Omnet++

## Usage

`docker run --rm -it -v `pwd`:/work ryankurte/docker-omnetpp`

To run with gui support on OSX:
1. Install XQuartz
2. Find IP with `ifconfig en0 | grep inet | awk '$1=="inet" {print $2}'`
3. Enable IP based access with `xhost + $IP`
4. Run with  ```docker run --rm -it -v `pwd`:/work -e DISPLAY=$IP:0 -v /tmp/.X11-unix:/tmp/.X11-unix ryankurte/docker-omnetpp```

