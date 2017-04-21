Jenkins Swarm Agent
-------------------

Usage
-----

The environment variable COMMAND_OPTIONS has to be specified with non-empty value, which is a combination of all swarm client options you need. Please refer to this [Swarm Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Swarm+Plugin) for all available options.

For the username and password, it makes use of [Docker Secrets](https://docs.docker.com/engine/swarm/secrets/).
You can run this service as follows:

```bash
docker service create --name $JENKINS_AGENT_SERVICE \
    --secret source=jenkins-master1-usr,target=jks-admin-usr \
    --secret source=jenkins-master1-pass,target=jks-admin-pass \
    -e USER_NAME_SECRET="/run/secrets/jks-admin-usr"\
    -e PASSWORD_SECRET="/run/secrets/jks-admin-pass"\
    -e COMMAND_OPTIONS="-master http://${MASTER_URL}:8080 \
    -labels 'docker' -executors 3
    -fsroot /tmp" \
    --network $NETWORK \
    --mode global \
    --mount "type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock" \
    --mount "type=bind,source=/tmp,target=/tmp/workspace" \
    vfarcic/jenkins-swarm-agent
```