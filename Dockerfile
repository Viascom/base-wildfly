FROM viascom/base-java:8

LABEL maintainer="technical@viascom.ch"

ENV WILDFLY_VERSION 10.1.0.Final
ENV WILDFLY_HOME /opt/wildfly

# Installs WILDFLY
RUN apk add --no-cache --virtual=build-dependencies wget && \
    cd "/tmp" && \
    wget -q http://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz && \
    tar xzvf wildfly-$WILDFLY_VERSION.tar.gz && \
    mv /tmp/wildfly-$WILDFLY_VERSION $WILDFLY_HOME && \
    apk del build-dependencies && \
    rm "/tmp/"*

# Expose the ports we're interested in
EXPOSE 8080

CMD ["/opt/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]
