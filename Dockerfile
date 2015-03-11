FROM ubuntu:14.04

RUN dpkg --add-architecture i386

RUN apt-get update && apt-get install -y firefox:i386 && \
                      apt-get install -y openjdk-7-jre:i386 && \
                      apt-get install -y icedtea-7-plugin:i386 && \
                      apt-get install -y openssh-server


RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

USER developer
ENV HOME /home/developer
CMD /usr/bin/firefox
