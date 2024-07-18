FROM python:3.10

ENV DEBIAN_FRONTEND noninteractive

RUN sed -i 's/deb.debian.org/debian.csie.ntu.edu.tw/g' /etc/apt/sources.list.d/debian.sources

WORKDIR /usr/src/app

RUN apt-get update && apt-get upgrade -y; \
apt-get install -y build-essential cmake libcurl4-gnutls-dev libnetcdf-dev wget tar gedit vim curl; \
apt-get install -y ghostscript gdal-bin libgdal-dev libglib2.0-dev libpcre3-dev libfftw3-dev liblapack-dev;

# Install Miniconda and Package
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash Miniconda3-latest-Linux-x86_64.sh -b
ENV PATH="/root/miniconda3/bin:$PATH"
COPY requirements_conda.txt ./requirements_conda.txt
RUN conda update -y conda;\
    conda install cartopy -c conda-forge -y
RUN rm Miniconda3-latest-Linux-x86_64.sh

# Install Python Package
COPY requirements_obspy.txt ./requirements.txt
RUN /root/miniconda3/bin/python -m pip install --upgrade pip; \
    /root/miniconda3/bin/python -m pip --no-cache-dir install -r requirements.txt;


# Install GMT 6.4.0
RUN wget https://github.com/GenericMappingTools/gmt/releases/download/6.4.0/gmt-6.4.0-src.tar.gz; \
    wget https://github.com/GenericMappingTools/gshhg-gmt/releases/download/2.3.7/gshhg-gmt-2.3.7.tar.gz; \
    wget https://github.com/GenericMappingTools/dcw-gmt/releases/download/2.1.2/dcw-gmt-2.1.2.tar.gz

RUN tar -xvf gmt-6.4.0-src.tar.gz; \
    tar -xvf gshhg-gmt-2.3.7.tar.gz; \
    tar -xvf dcw-gmt-2.1.2.tar.gz; \
    mv gshhg-gmt-2.3.7 gmt-6.4.0/share/gshhg-gmt; \
    mv dcw-gmt-2.1.2 gmt-6.4.0/share/dcw-gmt; 

WORKDIR gmt-6.4.0

RUN echo "set (CMAKE_INSTALL_PREFIX \"/opt/GMT6\")" > cmake/ConfigUser.cmake; \
    echo "set (GMT_USE_THREADS TRUE)" >> cmake/ConfigUser.cmake; \
    echo "set (GMT_ENABLE_OPENMP TRUE)" >> cmake/ConfigUser.cmake;

RUN mkdir build 
WORKDIR build 
RUN cmake ..
RUN make -j
RUN make -j install

ENV GMT6HOME="/opt/GMT6"
ENV PATH="$GMT6HOME/bin:$PATH"
ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$GMT6HOME/lib64"

WORKDIR /usr/src/app