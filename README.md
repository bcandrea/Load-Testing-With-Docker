Load Testing with Docker
========================

This repository contains an API solution built to request and receive responses from a docker stubby instance containing weather data for London, Paris, Rome and Tokyo.  It is designed to demonstrate the use of docker for load testing using Locust. In addition provide an understanding about the configuration setup between Dockerfile and Docker Compose files.

However, for those new to docker, this will provide the first stepping stone to get familiar with the technology.  I have made it more interesting by not providing all the necessary configuration settings in the files.  Below I have provided pointers of where to find the information for the Dockerfile and Docker Compose configuration settings, but you have to do the investigation to get instances spun up with locust to run the load test.

Instructions on how to use:
---------------------------

1.  Pull down on your mac or windows machine.  

2.  The main folder contains the API C# solution in the src folder along side three folders called:

    * ci-build
    * load-test
    * locust

    We are interested in the three 3 folders.  The API does not need amending.
    
3.  You will need to download Docker Tools from https://www.docker.com/products/docker-toolbox and follow the install    instructions.  Download Virtual Box Version 5.0.12 r104815 from https://www.virtualbox.org/ and install.

4.  In Virtual Box go to Settings->Network-Port forwarding.  Set the following ports:

    * Name - WLS    Host Port 9050 IP - 127.0.0.1 Guest Port 9050
    * Name - Locust Host Port 8089 IP - 127.0.0.1 Guest Port 8089
    * Name - Stub   Host Port 80   IP - 127.0.0.1 Guest Port 80
    
4.  You need to build the software before load testing.  In the ci-build folder there is a bash file called build.sh, this script will build the code in docker.  The following command will run the build.

    * ./ci-build/build.sh

5.  Next is to sin up the docker instances from the images.  At this point the images don't exist, so therefore the following command will invoke the downloading of the necessary support after you have completed the missing configuration in the Dockerfile and Docker Compose stub file.

   * docker-compose -f docker-compose-stub.yml up -d
   
6.  After the images is greated run the following command:

   * docker images
   
    This will list all the images on your local docker registry and will include the new images to run the laod test with Locust.

7.  To list the new containers:

    * docker ps -a
    
    This will list all the running containers and those that may have stopped.  You should see all the containers for the load test in a running state.  Take note of the STATUS column, this will inform how long the docker instance has been running and also if teh instances has stopped running.
    
7.  To stop the docker instance you can either stop or remove the container instances.  You may like to reset the containers before restarting or stop without removing.  The two following commnands manage both situations:
  
   * docker stop $(docker ps -aq)
   * docker rm -f $(docker ps -aq)
