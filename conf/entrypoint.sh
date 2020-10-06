#!/bin/bash

if [ -n "${CUSTOM_UID}" ];then
  echo "Using custom UID ${CUSTOM_UID}."
  IMAGE_UID=${CUSTOM_UID}
else
  echo "Using UID 1099"
  IMAGE_UID=1099
fi

if [ -n "${CUSTOM_GID}" ];then
  echo "Using custom GID ${CUSTOM_GID}."
  IMAGE_GID=${CUSTOM_GID}
else
  echo "Using GID 1099"
  IMAGE_GID=1099
fi

addgroup --gid ${IMAGE_GID} tomcat && useradd -m -u ${IMAGE_UID} -g tomcat tomcat
chown -R tomcat:tomcat .
chown -R tomcat:tomcat ${SOS_INSTALL_DIR}

su tomcat -c "/usr/local/tomcat/bin/catalina.sh run"