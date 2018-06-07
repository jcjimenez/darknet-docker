FROM ubuntu:16.04

RUN apt-get update && apt-get install -y apt-utils bzip2 curl wget git sudo unp cmake && apt-get clean && rm -rf /var/cache/apt
RUN apt-get -y autoremove && apt-get -y autoclean
RUN rm -rf /var/cache/apt

RUN git clone https://github.com/pjreddie/darknet /darknet
WORKDIR /darknet
RUN make

