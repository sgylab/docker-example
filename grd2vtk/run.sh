docker container rm -f grd2vtk
docker run \
    -it \
	--rm \
	-v $(pwd)/data:/data \
       	--name grd2vtk grd2vtk \
       /bin/bash	
