docker container rm -f obspy_ssh
docker run -d \
        -p 49154:22 \
        -p 8888:8888 \
        -v /etc/passwd:/etc/passwd:ro \
        -v /etc/shadow:/etc/shadow:ro \
        -v /etc/group:/etc/group:ro \
        -v <path/to/workspace>:/home/${USER} \
        --name obspy_ssh sgylab/obspy