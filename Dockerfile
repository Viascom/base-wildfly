FROM viascom/base-java:8

LABEL maintainer="technical@viascom.ch"

ENV WILDFLY_VERSION 10.1.0.Final
ENV WILDFLY_HOME /opt/wildfly

RUN mkdir -p $WILDFLY_HOME
RUN adduser -D -h /opt/wildfly wildfly

RUN apk add --no-cache curl tar

# Installs WILDFLY
RUN mkdir /temp && \
    cd /temp  && \
    curl -O -sSL http://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz && \
    tar -xzf wildfly-$WILDFLY_VERSION.tar.gz && \
    cp -r wildfly-$WILDFLY_VERSION/* $WILDFLY_HOME && \
    rm -rf /temp

# Expose the ports we're interested in
EXPOSE 8080 9990

USER root

# Add management user (username: admin, passwd: admin)
RUN $WILDFLY_HOME/bin/add-user.sh admin admin --silent

CMD ["/opt/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
