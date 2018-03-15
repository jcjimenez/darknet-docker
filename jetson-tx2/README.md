darknet-docker/jetson-tx2
=========================
This Dockerfile is meant to serve as a base image for running darnket/YOLO on
an NVIDIA Jetson TX2 board running JetPack 3.2.

Running
-------
Because `nvidia-docker` was not availabe for the Jetson TX2 at the time this
was written, I've included a similar wrapper script called `darknet-docker`
which can be used in place of `docker run` on the Jetson TX2 like so:

```
./darknet-docker run --rm -it jcjimenez/darknet-docker:jetson-tx2-latest
```

Building
--------
Sadly, the only reliable way I found to build this is to do so directly on the
Jetson. So, it is necessary to run a few commands before running
`docker build .`:

1. Build darknet directly on the TX2:

```
git clone https://github.com/pjreddie/darknet
cd darknet
sed -i s/GPU=0/GPU=1/g Makefile
sed -i s/CUDA=0/CUDA=1/g Makefile
sed -i s/OPENCV=0/OPENCV=1/g Makefile
make
cd ..
```

2. Build the docker image:

```
docker build .
```

