# Useful docker commands 
Update image:

    docker pull [image name]

Resume the container which is already existed:

    docker start [container name]

Remove container:

    docker container rm [container name]

Remove image:

    docker image rm [image name]

Remove all containers(!):

    docker rm -f $(docker ps -a -q)

Remove all images(!):

    docker rmi -f $(docker images -q)

