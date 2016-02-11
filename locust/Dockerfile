FROM ubuntu:15.10

RUN apt-get update && apt-get install -y \
                              python-setuptools \
                              python-dev \
                              python-pip \
                              libzmq-dev && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip install locustio isodate pyzmq

ADD . /locust
WORKDIR /locust

EXPOSE 8089 5557 5558

ENTRYPOINT ["bash", "./start.sh"]
CMD []
