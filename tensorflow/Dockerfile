FROM tensorflow/tensorflow:2.6.0-gpu-jupyter

# Ignore all interactive dialog during apt-get update
ENV DEBIAN_FRONTEND noninteractive

# nodejs source
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

# Install linux package
RUN apt-mark hold libcudnn* cuda*; \
    apt-get update && apt-get upgrade -y; \
    apt-get install -y \
        build-essential gcc gfortran libgfortran3 \
        libproj-dev proj-data proj-bin libgeos-dev \
        libx11-dev libx11-xcb-dev xorg openbox \
        openssh-server \
        sudo vim git nodejs ffmpeg graphviz \
        htop iotop screen reptyr;

# Add all user into sudoers
RUN echo '%staff   ALL=(ALL:ALL) ALL' >> /etc/sudoers;

# Install python packages in requirements.txt
COPY tensorflow/requirements.txt /tmp/
RUN python -m pip install --upgrade pip; \
    python -m pip install shapely --no-binary shapely; \
    python -m pip --no-cache-dir install --upgrade --requirement /tmp/requirements.txt;

# Jupyter Lab interactive plot
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build; \
    jupyter labextension install jupyter-matplotlib --no-build; \
    jupyter lab build;

# Change jupyter python kernel
RUN sed -i 's/\/usr\/bin\/python3/\/usr\/local\/bin\/python/g' /usr/local/share/jupyter/kernels/python3/kernel.json;

# Fix X11 forwarding request failed on channel 0
RUN sed -i 's/#X11UseLocalhost yes/X11UseLocalhost no/g' /etc/ssh/sshd_config;

# SSH login fix. Otherwise user is kicked off after login
RUN mkdir /var/run/sshd; \
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config; \
    sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd;

# Hide server profile form docker container, only which written into '/etc/profile' will be seen
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile;

# Set CUDA path and SeisBlue source code path
RUN echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64" >> /etc/profile; 

# Delete tensorflow login message for sftp login by replacing default .bashrc
RUN mv /etc/bash.bashrc /etc/bash.bashrc.old; \
    cp /etc/skel/.bashrc /etc/bash.bashrc;

# Open SSH port 22 and make SSHD standby for incoming connection
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]