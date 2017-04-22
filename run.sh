read PSS < ${PASSWORD_SECRET}
read USR < ${USER_NAME_SECRET}
java -jar /home/jenkins/swarm-client-${SWARM_CLIENT_VERSION}.jar ${COMMAND_OPTIONS} -username $USR -password $PSS