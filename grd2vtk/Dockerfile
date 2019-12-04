FROM ubuntu:18.04

RUN sed -i 's/archive.ubuntu.com/free.nchc.org.tw/g' /etc/apt/sources.list
RUN apt-get update && apt-get upgrade -y && apt-get install gcc gawk wget ftp make git bzip2 g++ libc6 ghostscript libnetcdf-dev libgdal-dev python-gdal libxaw7-dev libice-dev libsm-dev libx11-dev libxext-dev libxmu-dev libxt-dev -y

RUN wget ftp://ftp.soest.hawaii.edu/gmt/gmt-4.5.18-src.tar.bz2; wget ftp://ftp.soest.hawaii.edu/gmt/gshhg-gmt-2.3.7.tar.gz; wget ftp://ftp.soest.hawaii.edu/gmt/dcw-gmt-1.1.4.tar.gz

RUN tar -xvf gmt-4.5.18-src.tar.bz2; cd gmt-4.5.18; ./configure --prefix=/opt/GMT-4.5.18; make -j; make install-all 
RUN cd ../; tar -xvf gshhg-gmt-2.3.7.tar.gz; mv gshhg-gmt-2.3.7 /opt/GMT-4.5.18/share/coast
ENV GMT4HOME "/opt/GMT-4.5.18"
ENV PATH="${GMT4HOME}/bin:${PATH}"
ENV LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${GMT4HOME}/lib64"

ENV AWKPATH "/grd2vtk"
ENV PATH="/grd2vtk:${PATH}"
ENV PATH="/grd2vtk/bin/x86_64:${PATH}"
RUN cd /; git clone https://github.com/thwbecker/grd2vtk.git
RUN cd grd2vtk; make
