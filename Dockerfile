FROM tomcat:9-jre8

LABEL maintainer="geomatico <info@geomatico.es>"

ENV SOS_VERSION 5.3.1
ENV SOS_INSTALL_DIR /usr/local/52n-sos

# 52n-sos
RUN mkdir -p /usr/local/tomcat/conf/Catalina/localhost \
    && echo '<Context path="/52n-sos" docBase="/usr/local/52n-sos"></Context>' > /usr/local/tomcat/conf/Catalina/localhost/52n-sos.xml
RUN mkdir ${SOS_INSTALL_DIR} \
        && cd ${SOS_INSTALL_DIR} \
        && wget https://github.com/52North/SOS/releases/download/v${SOS_VERSION}/52n-sensorweb-sos-${SOS_VERSION}.zip \
        && unzip -j 52n-sensorweb-sos-${SOS_VERSION}.zip */52n-sos-webapp.war -d . \
        && unzip 52n-sos-webapp.war \
        && rm -rf 52n-sensorweb-sos-${SOS_VERSION}.zip 52n-sos-webapp.war target *.txt

# Tomcat environment
ENV CATALINA_OPTS "-server -Djava.awt.headless=true \
	-Xms768m -Xmx1560m -XX:+UseConcMarkSweepGC -XX:NewSize=48m"

ADD conf/entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT [ "entrypoint.sh" ]

EXPOSE 8080