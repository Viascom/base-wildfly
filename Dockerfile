FROM viascom/base-java:8

LABEL maintainer="technical@viascom.ch"

ENV WILDFLY_VERSION 11.0.0.Final
ENV WILDFLY_HOME /opt/wildfly

RUN apk add --update curl tar

# Installs WILDFLY
WORKDIR /tmp
RUN curl -O -sSL http://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz
RUN tar -xzf wildfly-$WILDFLY_VERSION.tar.gz
RUN rm wildfly-$WILDFLY_VERSION.tar.gz
RUN mv wildfly-$WILDFLY_VERSION $WILDFLY_HOME

RUN apk del curl tar

# Expose the ports we're interested in
EXPOSE 8080 9990

# Add management user (username: admin, passwd: admin)
#RUN $WILDFLY_HOME/bin/add-user.sh admin admin --silent

CMD ["/opt/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
