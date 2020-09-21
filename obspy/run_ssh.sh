docker container rm -f obspy_ssh
docker run -d \
        -p 4444:22 \
        -p 8888:8888 \
        -p 6006:6006 \
        -v /etc/passwd:/etc/passwd:ro \
        -v /etc/shadow:/etc/shadow:ro \
        -v /etc/group:/etc/group:ro \
        -v /mnt/NAS_232/jue/workspace:/home/${USER} \
        --name obspy_ssh obspy