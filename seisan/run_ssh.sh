docker container rm -f seisan_ssh
docker run -d \
        -p 49154:22 \
        -v /etc/passwd:/etc/passwd:ro \
        -v /etc/shadow:/etc/shadow:ro \
        -v /etc/group:/etc/group:ro \
        -v <path/to/workspace>:/home/${USER} \
        -v <path/to/Archive>:/home/${USER}/Archive \
        --name seisan_ssh sgylab/seisan