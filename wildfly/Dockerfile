FROM nancom/debian-jdk7:wheezy

# Set the WILDFLY_VERSION env variable
ENV WILDFLY_VERSION 8.2.1.Final
ENV WILDFLY_SHA1 77161d682005f26acb9d2df5548c8623ba3a4905
ENV JBOSS_HOME /opt/jboss/wildfly
ENV AUTHORIZED_KEYS **None**
# Add the WildFly distribution to /opt, and make wildfly the owner of the extracted tar content
# Make sure the distribution is available from a well-known place
RUN groupadd -r jboss -g 1000 && useradd -u 1000 -r -g jboss -m -d /opt/jboss -s /sbin/nologin -c "JBoss user" jboss && \
    chmod 755 /opt/jboss
WORKDIR /opt/jboss
USER jboss
RUN cd $HOME \
    && curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
    && sha1sum wildfly-$WILDFLY_VERSION.tar.gz | grep $WILDFLY_SHA1 \
    && tar xf wildfly-$WILDFLY_VERSION.tar.gz \
    && mv $HOME/wildfly-$WILDFLY_VERSION $JBOSS_HOME \
    && rm wildfly-$WILDFLY_VERSION.tar.gz

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh

USER root
RUN chmod +x /*.sh

# Expose the ports we're interested in
EXPOSE 8080
EXPOSE 22
# Set the default command to run on boot
# This will boot WildFly in the standalone mode and bind to all interface
CMD /run.sh && /opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0
