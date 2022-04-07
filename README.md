# Unapei/CapFalc Docker Image

## Purpose

The purpose of this project is to setup easily an environment to run the [UNAPEI](https://www.unapei.org/) application : [CapFalc](https://www.unapei.org/presse/capfalc-un-outil-numerique-pour-rendre-les-informations-accessibles-aux-personnes-en-situation-de-handicap-intellectuel/) application.

This application should be able to run on a dedicated instance of the [SSPCloud](https://www.sspcloud.fr/) datalab application [Onyxia](https://github.com/InseeFrLab/onyxia-web) to demonstrate the possibilities of the platform.

## Target Platform

Still under development : [Onyxia target plaform](https://onyxia.codatalab.eu/)

## Docker Image

The image is publicly available on [DockerHub](https://hub.docker.com/repository/docker/cleyrop/codatalab-unapei).

## Pre-requisite

To build this image you'll need at least to have git and docker installed on a linux box.

To run this image you'll need a running [MariaDB](https://hub.docker.com/_/mariadb/) instance to connect to.

The image relies on the following parameters :

- DRUPAL_DATABASE_HOST : your MariaDB host IP or DNS name
- DRUPAL_DATABASE_PORT_NUMBER : the port number to acces your MariaDB instance, default is `3306`
- DRUPAL_DATABASE_NAME : the name of your database, e.g. `unapei`
- DRUPAL_DATABASE_USER : a user name that has rights on you db instance
- DRUPAL_DATABASE_PASSWORD : the user password
- DRUPAL_SITE_URL_LABEL : a key label to map your drupal site properly, depending on the accessible URL of the site, please refer to the [official Drupal Documentation](https://api.drupal.org/api/drupal/sites!example.sites.php/latest)

## Config

A `config` directory contains the properties used by the scripts to build and run the image.

Here are the few necessary properties :

- name : the name of the docker image, by default : `cleyrop/codatalab-unapei`
- version : the version of the docker image, e.g. `1.2.0`
- container : the name of the running container when run with default script, e.g. `unapei`

## Scripts

The project contains a `scripts` directory with some easy to remind scripts/commands :

### Build

To build this image, once you've clone the code, just run :

```bash
./build.sh [--no-cache]
```

`[--no-cache]` option can be passed to force build without cache.

### Test

If you want to test the image content, from the `scripts` directory run :

```bash
./check.sh
```

To get some informations about the content of the image, libraries, extensions and versions, from the `scripts` directories, run :

```bash
./check_versions.sh
```

### Run

To run this image localy, from the `scripts` directory, run :

```bash
./run.sh
```

### Deploy

Deployment to dockerhub can be done, by running the following command from the `scripts` directory :

```bash
./deploy.sh
```

### ALL

To run all commands in a raw, use :

```bash
./all.sh [--no-cache]
```

### Exec

To execute a shell in the docker container (as root by default but could be changed)

```bash
./exec.sh [--no-cache]
```
