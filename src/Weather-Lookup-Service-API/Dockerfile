FROM mono:4.2.1
ADD ./bin/Release /service
WORKDIR /service
ENTRYPOINT ["mono", "./Weather-Lookup-Service-API.exe"]
CMD []
EXPOSE 9050
