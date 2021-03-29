# SEISAN Docker Image

[run_ssh.sh](run_ssh.sh) will remove the previous created container and start a new one.



In [run_ssh.sh](run_ssh.sh):

``` bash
docker container rm -f seisan_ssh
docker run -d \
        -p 49154:22 \
        -v /etc/passwd:/etc/passwd:ro \
        -v /etc/shadow:/etc/shadow:ro \
        -v /etc/group:/etc/group:ro \
        -v <path/to/workspace>:/home/${USER} \
        -v <path/to/Archive>:/home/${USER}/Archive \
        --name seisan_ssh sgylab/seisan
```

1. Create a workspace directory.
2. Link `<path/to/workspace>` to the user home directory.
3. Link `<path/to/Archive>` to the archive waveform directory.
4. Change `49154` to any number for SSH port.
5. Change `seisan_ssh` to any container name.
6. Save and run `run_ssh.sh`.
7. SSH into the docker container with your user account.

       ssh user@127.0.0.1 -p49154

8. Copy `SEISAN.DEF` and `STATION0.hyp` to your workspace and change the settings.

## Git LFS

        git lfs install
        git lfs track '*.tar.gz'
        git add .gitattributes

        git add seisan/seisan_v11_linux_64.tar.gz
        git commit -m "Add seisan file"
        git push 

        git lfs push origin --all