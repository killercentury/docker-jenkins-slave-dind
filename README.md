# Jenkins Slave DinD (Docker in Docker)

This Jenkins Slave Docker image inherits the same idea as [the master one](https://hub.docker.com/r/killercentury/jenkins-dind/) that provides Docker Engine and Docker Compose inside itself, which allows you to run anything via Docker container in your Jenkins build script. So it also means that you don't need a custom build of Jenkins that pre-install any build tool or runtime anymore. You can provide all these via Docker images in your build script, which guarantees a highly isolated environment between jobs as well.

This Docker image is based on [jpetazzo/dind](https://registry.hub.docker.com/u/jpetazzo/dind/) to provide the DinD (Docker in Docker) environment. [Supervisord](http://supervisord.org) is used to make sure everything has proper permission and launch in the right order. [Jenkins Swarm Client](http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/plugins/swarm-client/) is used to connect with the master in an intelligent way. Moreover, [Docker Compose](https://github.com/docker/compose) is available for launching multiple containers inside the CI.

This Jenkins slave image should be able to connect with any Jenkins master with JNLP enabled, such as [killercentury/jenkins-dind](https://hub.docker.com/r/killercentury/jenkins-dind/) and normal Jenkins installed manually or via package manager.

## Usage

The environment variable COMMAND_OPTIONS has to be specified with non-empty value, which is a combination of all swarm client options you need. Please refer to this [Swarm Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Swarm+Plugin) for all available options.

```
docker run --name jenkins-slave-dind --privileged -d -e COMMAND_OPTIONS="-master http://YOUR-JENKINS-MASTER-HOST:YOUR-JENKINS-MASTER-PORT -username YOUR_SLAVE_USERNAME -password YOUR_SLAVE_PASSWORD" killercentury/jenkins-slave-dind
```
