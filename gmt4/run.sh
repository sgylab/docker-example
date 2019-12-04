docker container rm -f gmt4
docker run \
    -it \
	--rm \
	-v $(pwd)/data:/data \
       	--name gmt4_image gmt4 \
       /bin/bash	
