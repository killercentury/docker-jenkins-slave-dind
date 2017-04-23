set +e

read PSS < ${PASSWORD_SECRET}
read USR < ${USER_NAME_SECRET}

set -e

if [ -z "$PSS" ]
then
    java -jar /home/jenkins/swarm-client-${SWARM_CLIENT_VERSION}.jar ${COMMAND_OPTIONS}
else
    java -jar /home/jenkins/swarm-client-${SWARM_CLIENT_VERSION}.jar ${COMMAND_OPTIONS} -username $USR -password $PSS
fi
