if [ -f "${USER_NAME_SECRET}" ]; then
    read USR < ${USER_NAME_SECRET}    
    COMMAND_OPTIONS="${COMMAND_OPTIONS} -username $USR"
fi

if [ -f "${PASSWORD_SECRET}" ]; then
    read PSS < ${PASSWORD_SECRET}
    export PSS
    COMMAND_OPTIONS="${COMMAND_OPTIONS} -passwordEnvVariable PSS"
fi

GROUP=$(stat -c %G /var/run/docker.sock)
if [ ! $(grep ^$GROUP: /etc/group) ]; then
    addgroup -G $(stat -c %g /var/run/docker.sock) $GROUP
fi
adduser jenkins $GROUP

exec su jenkins -c "exec java -jar /home/jenkins/swarm-client-${SWARM_CLIENT_VERSION}.jar ${COMMAND_OPTIONS}"
