# Minimal Docker image for fqtools using Alpine base
FROM alpine:latest

# install fqtools
RUN apk update && \
    apk add --no-cache bash bzip2-dev g++ make xz-dev zlib-dev && \

    # install htslib
    wget -qO- "https://github.com/samtools/htslib/releases/download/1.24/htslib-1.24.tar.bz2" | tar -xj && \
    cd htslib-* && \
    ./configure && \
    make && \
    make install && \
    cd .. && \

    # install fqtools
    wget -qO- "https://github.com/alastair-droop/fqtools/archive/refs/tags/v2.3.tar.gz" | tar -zx && \
    cd fqtools-* && \
    make CFLAGS="-O2 -g -Wno-error=incompatible-pointer-types -fcommon" && \
    mv bin/fqtools /usr/local/bin/ && \
    cd .. && \

    # clean things up
    rm -rf fqtools-* htslib-*
