FROM ubuntu:15.10

RUN apt-get update && apt-get install -y \
                              python-setuptools \
                              python-dev \
                              python-pip \
                              libzmq-dev && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
