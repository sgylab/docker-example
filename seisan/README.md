# Obspy Docker Image

[run_ssh.sh](run_ssh.sh) will remove the previous created container and start a new one.



In [run_ssh.sh](run_ssh.sh):

``` bash
docker container rm -f obspy_ssh
docker run -d \
        -p 49154:22 \
        -v /etc/passwd:/etc/passwd:ro \
        -v /etc/shadow:/etc/shadow:ro \
        -v /etc/group:/etc/group:ro \
        -v <path/to/workspace>:/home/${USER} \
        --name seisan_ssh sgylab/seisan
```

1. Create a workspace directory.
2. Link `<path/to/workspace>` to the user home directory.
3. Change `49154` to any number for SSH port.
4. Change `seisan_ssh` to any container name.
5. Save and run `run_ssh.sh`.
6. SSH into the docker container with your user account.

       ssh user@127.0.0.1 -p49154

## Git LFS

        git lfs install
        git lfs track '*.tar.gz'
        git add .gitattributes

        git add seisan/seisan_v11_linux_64.tar.gz
        git commit -m "Add seisan file"
        git push 

        git lfs push origin --all