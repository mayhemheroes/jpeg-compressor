FROM --platform=linux/amd64 ubuntu:20.04

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential cmake

ADD . /jpeg-compressor
WORKDIR /jpeg-compressor/build
RUN cmake ..
RUN make -j8
