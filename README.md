# Docker Example

This repo has two purpose:

1. Demonstrates how to build docker images by Github Actions.
2. Maintains docker images used by [SGYLAB](https://sgylab.earth.ncu.edu.tw/).

The Github Actions are in [.github/workflows](.github/workflows).

## Image build status

Docker Image|Status
:-----------|:-----
[sgylab/obspy](obspy)|![Obspy Docker Image](https://github.com/sgylab/docker-example/workflows/Obspy%20Docker%20Image/badge.svg)

## Useful docker commands 

Build image:

    docker build -t [image name] .

Update image:

    docker pull [image name]

List exist container:

    docker container ls

Resume stopped container:

    docker start [container name]

Remove container:

    docker container rm [container name]

Remove image:

    docker image rm [image name]

## Danger zone

Remove all containers(!):

    docker rm -f $(docker ps -a -q)

Remove all images(!):

    docker rmi -f $(docker images -q)

