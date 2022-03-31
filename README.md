# CapFALC Run Docker Image

## Purpose

The purpose of this project is to setup easily an environment to run the application.

This application should be able to run on a dedicated Onyxia SSPCloud instance to demonstrate all the possibilities of the platform.

(Onyxia target plaform)[https://onyxia.codatalab.eu/home]

## Docker Image

The image is publicly available on (DockerHub)[https://hub.docker.com/repository/docker/cleyrop/capfalc].

### Build

To build this image, once you've clone the code, go to the `scripts` directory and just run :

````
./build.sh
````

### Test

If you want to test the image content, from the `scripts` directory run :

````
./check.sh
````

To get some informations about the content of the image, libraries, extensions and versions, from the `scripts` directories, run :

````
./check_versions.sh
````

### Run

To run this image localy, from the `scripts` directory, run :

```
./run.sh
```

### Deploy

Deployment to dockerhub can be done, by running the following command from the `scripts` directory :

```
./deploy.sh
```

