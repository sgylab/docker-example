FROM ubuntu:18.04

# Ignore all interactive dialog during apt-get update
ENV DEBIAN_FRONTEND noninteractive

# Install linux package
RUN apt-get update --fix-missing && apt-get upgrade -y; \
    apt-get install -y \
    build-essential gcc gfortran libgfortran3 \
    sudo vim git curl openssh-server \
    libx11-dev libx11-xcb-dev xorg openbox \
    htop iotop screen reptyr;

# Add all user into sudoers
RUN echo '%staff   ALL=(ALL:ALL) ALL' >> /etc/sudoers;

# Install SEISAN
RUN mkdir /opt/seismo; 
COPY seisan/seisan_v11_linux_64.tar.gz /opt/seismo/
WORKDIR /opt/seismo
RUN gunzip seisan_v11_linux_64.tar.gz; tar xvf seisan_v11_linux_64.tar; \
    sed -i 's/SEISARCH="linux64"/SEISARCH="gfortran"/g' /opt/seismo/COM/SEISAN.bash; \
    sed -i 's/SEISAN_TOP="\/home\/s2000\/seismo"/SEISAN_TOP="\/opt\/seismo"/g' /opt/seismo/COM/SEISAN.bash; \
    chmod 777 -R /opt/seismo

# SSH login fix. Otherwise user is kicked off after login
RUN mkdir /var/run/sshd; \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd;

# Hide server profile form docker container, only which written into '/etc/profile' will be seen
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile;

# Fix X11 forwarding request failed on channel 0
RUN sed -i 's/#X11UseLocalhost yes/X11UseLocalhost no/g' /etc/ssh/sshd_config;

# Clear login message for sftp login
RUN cp /etc/skel/.bashrc /etc/bash.bashrc;

# Add SEISAN to bashrc
RUN echo 'source /opt/seismo/COM/SEISAN.bash' >> /etc/bash.bashrc; \
    echo 'alias select="/home/user/seismo/PRO/select"' >> /etc/bash.bashrc;

# Start ssh service
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]