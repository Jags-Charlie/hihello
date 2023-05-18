FROM jenkins/jenkins
USER root
RUN mkdir -p /tmp/download && \
curl -L https://get.docker.com/builds/Linux/x86_64/docker-1.13.1.tgz | tar -xz -C /tmp/download && \
rm -rf /tmp/download/docker/dockerd && \
mv /tmp/download/docker/docker* /usr/local/bin/ && rm -rf /tmp/download && groupadd -g 999 docker && usermod -aG docker jenkins
# USER jenkins
RUN apt update
RUN apt install software-properties-common -y
RUN apt install ansible -y
RUN apt install python3 python3-pip -y
RUN pip3 install docker
