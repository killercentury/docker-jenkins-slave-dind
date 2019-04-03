Jenkins Swarm Agent
-------------------

Usage
-----

The environment variable COMMAND_OPTIONS has to be specified with non-empty value, which is a combination of all swarm client options you need. Please refer to this [Swarm Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Swarm+Plugin) for all available options.

Please see [jenkins-swarm-agent.yml](https://github.com/vfarcic/docker-flow-stacks/tree/master/jenkins#jenkins-swarm-agentyml) for an example how to use *Jenkins Swarm Agent* with Jenkins master username and password specified as environment variables.

Please see [jenkins-swarm-agent-secrets.yml](https://github.com/vfarcic/docker-flow-stacks/tree/master/jenkins#jenkins-swarm-agent-secretsyml) for an example how to use *Jenkins Swarm Agent* with Jenkins master username and password specified as Docker secrets.
