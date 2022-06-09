FROM --platform=linux/amd64 ubuntu:20.04 as builder

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential cmake

ADD . /jpeg-compressor
WORKDIR /jpeg-compressor/build
RUN cmake ..
RUN make -j8

RUN mkdir -p /deps
RUN ldd /jpeg-compressor/bin/jpge | tr -s '[:blank:]' '\n' | grep '^/' | xargs -I % sh -c 'cp % /deps;'

FROM ubuntu:20.04 as package

COPY --from=builder /deps /deps
COPY --from=builder /jpeg-compressor/bin/jpge /jpeg-compressor/bin/jpge
ENV LD_LIBRARY_PATH=/deps
