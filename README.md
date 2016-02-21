Load Testing with Docker
========================

This repository contains an API solution built to request and receive responses from a docker stubby instance containing weather data for London, Paris, Rome and Tokyo.  It is designed to demonstrate the use of docker for load testing using Locust. In addition provide an understanding about the configuration setup between Dockerfile and Docker Compose files.

However, for those new to docker, this will provide the first stepping stone to get familiar with the technology.  I have made it more interesting by not providing all the necessary configuration settings in the files.  Below I have provided help on where to place the configuration for the Dockerfile and Docker Compose configuration settings, this will help you get used to working with the Dockerfile and Docker Compose file.

Instructions on how to use:
---------------------------

1.  Pull down from this repository to your mac or windows machine.  

2.  The main folder contains the API C# solution in the src folder along side three folders called:

    * ci-build
    * load-test
    * locust

    We are interested in the three 3 folders.  The API does not need amending.
    
3.  You will need to download Docker Tools from https://www.docker.com/products/docker-toolbox and follow the install    instructions.  Download Virtual Box Version 5.0.12 r104815 from https://www.virtualbox.org/ and install.

4.   Amend the docker-compose-stub.yml file to include the following configuration:

         api:  
            image: mono:4.2.1  
            ports:  
               - "9050:9050"  
            volumes:  
               - .:/build  
            links:  
               - appstub:weather-lookup-service  
            command: mono /build/src/Weather-Lookup-Service-API/bin/Release/Weather-Lookup-Service-API.exe
   
      This section should follow the appstub section.  The indentaton must be maintained to be processed.
      
5.    Amend the Dockerfile file in the locust directory to include the following config:

         RUN pip install locustio isodate pyzmq
   
         ADD . /locust
         WORKDIR /locust
         
         EXPOSE 8089 5557 5558
         
         ENTRYPOINT ["bash", "./start.sh"]
         CMD []
      
      This will set the working directory and expose ports from the images and run the start bash.sh.

6.  You can use docker tools to start and stop the VM.  If you the stop the VM the docker deamon will not operate and therefore no docker command can run.  So therefore check the status.

   * the command to start the VM on the default installation is: docker-machine start default
   * the command to stop the VM on the default installation is: docker-machine stop default
   * this command will check the current status of the VM: docker-machine status default (displays 'Running')

7.  In Virtual Box go to Settings->Network-Port forwarding.  Set the following ports:

    * Name - WLS    Host Port 9050 IP - 127.0.0.1 Guest Port 9050
    * Name - Locust Host Port 8089 IP - 127.0.0.1 Guest Port 8089
    * Name - Stub   Host Port 80   IP - 127.0.0.1 Guest Port 80
    
8. Before building the solution the nuget packages need downloading.  In the root directory of the solution run the following command.

   * nuget restore Weather-Lookup-Service.sln (Mac users)
   * nuget install packages.config (Windows users)
    
9.  You need to build the software before load testing.  In the ci-build folder there is a bash file called build.sh, this script will build the code in docker.  The following command will run the build from the root directory of the project.

    * ./ci-build/build.sh

10.  Next is to sin up the docker instances from the images.  At this point the images don't exist, so therefore the following command from the root directory of the project will invoke the downloading of the necessary support after you have completed the missing configuration in the Dockerfile and Docker Compose stub file.

   * docker-compose -f docker-compose-stub.yml up -d
   
11.  After the images is greated run the following command:

   * docker images
   
    This will list all the images on your local docker registry and will include the new images to run the laod test with Locust.

12.  To list the new containers:

    * docker ps -a
    
    This will list all the running containers and those that may have stopped.  You should see all the containers for the load test in a running state.  Take note of the STATUS column, this will inform how long the docker instance has been running and also if teh instances has stopped running.
    
13.  To stop the docker instances you can either stop or remove the container instances.  The two following commnands manage both situations:
  
   * to stop the instances:   docker stop $(docker ps -aq)
   * to remove the instances: docker rm -f $(docker ps -aq)

14. To run the load test spin up the docker instances if not running as shown in step 10.  Open your browser of choice and go to http://localhost:8089.  Locust will open prompting you for the number of users and Hatch rate (users spawned/second). Type in 5 for users and 1 for the hatch rate and select Start swarning.  Locust will use a python program to task wait each endpoint for the weather data requested.  Select the stop button to stop the load test.
