FROM mono:4.2.1
ADD . /build
WORKDIR /build
RUN apt-get update && apt-get install -y nuget nunit && apt-get clean
EXPOSE 9050, 8882
