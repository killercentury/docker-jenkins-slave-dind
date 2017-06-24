FROM jpetazzo/dind

MAINTAINER Decheng Zhang <killercentury@gmail.com>

ENV SWARM_CLIENT_VERSION 3.4
ENV DOCKER_COMPOSE_VERSION 1.14.0

# Add a Jenkins user with permission to run docker commands
RUN useradd -r -m -G docker jenkins

# Install necessary packages (with JDK 8)
RUN apt-get -q update &&\
    apt-get -q install -y --no-install-recommends software-properties-common &&\
    add-apt-repository -y ppa:openjdk-r/ppa &&\
    apt-get -q update &&\
    apt-get -q install -y --no-install-recommends openjdk-8-jre-headless curl zip supervisor &&\
apt-get -q clean -y && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin

# Install Jenkins Swarm Client
RUN wget -q https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/${SWARM_CLIENT_VERSION}/swarm-client-${SWARM_CLIENT_VERSION}-jar-with-dependencies.jar -P /home/jenkins

# Install Docker Compose
RUN curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]
