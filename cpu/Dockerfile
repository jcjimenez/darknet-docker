FROM alpine:3.7

RUN apk add --update --no-cache \
    alpine-sdk

# Install darknet
RUN git clone https://github.com/pjreddie/darknet.git /darknet
WORKDIR /darknet
RUN git checkout f6d861736038da22c9eb0739dca84003c5a5e275
RUN echo '#include <sys/select.h>' > examples/go.c.updated
RUN cat examples/go.c >> examples/go.c.updated
RUN mv examples/go.c.updated examples/go.c
RUN make

