darknet-docker
===

This repo contains a collection of Docker images that can be used to run
darknet (YOLO) on different devices, primarily the NVIDIA Jetson TX2.

Running on Jetson TX2
---
Because `nvidia-docker` was not availabe for the Jetson TX2 at the time this
was written, I've included a similar wrapper script under `jetson-tx2/darknet-docker`
which can be used in place of `docker run` on the Jetson TX2 like so:

```
./darknet-docker run --rm -it jcjimenez/darknet-docker:jetson-tx2-latest
```

Running on a GPU machine
---
Make sure you have `nvidia-docker` installed to run:

```
nvidia-docker run --rm -it jcjimenez/darknet-docker:gpu-latest
```

Running on a plain CPU machine
---
Since this is a CPU-based image, you can just use the regular docker command:

```
docker run --rm -it jcjimenez/darknet-docker:cpu-latest
```

