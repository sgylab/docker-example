FROM ubuntu:18.04

# Ignore all interactive dialog during apt-get update
ENV DEBIAN_FRONTEND noninteractive

# RUN sed -i 's/archive.ubuntu.com/free.nchc.org.tw/g' /etc/apt/sources.list
RUN apt-get update && apt-get upgrade -y
RUN apt-get install build-essential gcc gfortran libgfortran3 libx11-dev libx11-xcb-dev xorg openbox curl sudo openssh-server vim htop screen reptyr git -y

# Add all user into sudoers
RUN echo '%staff   ALL=(ALL:ALL) ALL' >> /etc/sudoers

# Install SEISAN
RUN mkdir /opt/seismo; chmod a+x /opt/seismo
COPY seisan/seisan_v11_linux_64.tar.gz /opt/seismo/
WORKDIR /opt/seismo
RUN gunzip seisan_v11_linux_64.tar.gz; tar xvf seisan_v11_linux_64.tar; sed -i 's/SEISARCH="linux64"/SEISARCH="gfortran"/g' /opt/seismo/COM/SEISAN.bash; sed -i 's/SEISAN_TOP="\/home\/s2000\/seismo"/SEISAN_TOP="\/opt\/seismo"/g' /opt/seismo/COM/SEISAN.bash

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN mkdir /var/run/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN sed -i 's/#X11UseLocalhost yes/X11UseLocalhost no/g' /etc/ssh/sshd_config

# Clear login message for sftp login and add ls color
RUN echo 'alias ls="ls --color"' > /etc/bash.bashrc

# Add SEISAN to bashrc
RUN echo 'source /opt/seismo/COM/SEISAN.bash' >> /etc/bash.bashrc; echo 'alias select="/home/user/seismo/PRO/select"' >> /etc/bash.bashrc

# Start ssh service
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]