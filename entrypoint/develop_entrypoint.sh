#!/bin/sh

WEB_USER="www-data"

echo $DOCKER_UID $DOCKER_GID
whoami

echo "Setting the correct user and group id for shell use"

echo "Change Docker user id"
usermod -u ${DOCKER_UID} ${WEB_USER}

echo "Change Docker group id"
groupmod -g ${DOCKER_GID} ${WEB_USER}

CURRENT_UID=$(id -u ${WEB_USER})
CURRENT_GID=$(id -g ${WEB_USER})
echo "USER: ${WEB_USER} userid: ${CURRENT_UID} and group id ${CURRENT_GID}"

echo "Setup xdebug"
cp ${XDEBUG_CONF_FILE}.orig ${XDEBUG_CONF_FILE}

if [ -z ${XDEBUG_HOST} ]; then
  ip=$(netstat -rn | grep "^0.0.0.0 " | cut -d " " -f10)
  XDEBUG_HOST=${ip}
fi

echo "xdebug.client_host=${XDEBUG_HOST}" >>${XDEBUG_CONF_FILE}
echo "xdebug.client_port=${XDEBUG_PORT}" >>${XDEBUG_CONF_FILE}

if [ XDEBUG_DBGP = TRUE ]; then
  echo "xdebug.remote.handler=dbgp" >>${XDEBUG_CONF_FILE}
fi

if [ ! -z "${XDEBUG_IDE_KEY}" ]; then
  echo "xdebug.idekey=\"${XDEBUG_IDE_KEY}\"" >>${XDEBUG_CONF_FILE}
fi

echo "Fixing execution permissions"
find /var/www/html -iname "*.php" | xargs chmod 777


echo "Launch application"
exec "$@"
