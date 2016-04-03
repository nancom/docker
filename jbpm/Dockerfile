FROM nancom/wildfly:8

####### MAINTAINER ############
MAINTAINER "Panupong Chantaklang" "nancomsp@gmail.com"

####### ENVIRONMENT ############
ENV JBOSS_BIND_ADDRESS 0.0.0.0
ENV KIE_REPOSITORY https://repository.jboss.org/nexus/content/groups/public-jboss
ENV KIE_VERSION 6.3.0.Final
ENV KIE_CLASSIFIER wildfly8
ENV KIE_CONTEXT_PATH jbpm-console
ENV DASHBUILDER_CONTEXT_PATH dashbuilder
ENV JAVA_OPTS -XX:MaxPermSize=256m -Xms256m -Xmx512m

# Do NOT use demo neither examples by default in this image (no internet connection required).
ENV KIE_DEMO false
ENV KIE_SERVER_PROFILE standalone-full

####### JBPM-WB ############
RUN curl -o $HOME/$KIE_CONTEXT_PATH.war $KIE_REPOSITORY/org/kie/kie-wb-distribution-wars/$KIE_VERSION/kie-wb-distribution-wars-$KIE_VERSION-$KIE_CLASSIFIER.war && \
unzip -q $HOME/$KIE_CONTEXT_PATH.war -d $JBOSS_HOME/standalone/deployments/$KIE_CONTEXT_PATH.war &&  \
touch $JBOSS_HOME/standalone/deployments/$KIE_CONTEXT_PATH.war.dodeploy &&  \ 
rm -rf $HOME/$KIE_CONTEXT_PATH.war

####### JBPM DASHBUILDER ############
RUN curl -o $HOME/$DASHBUILDER_CONTEXT_PATH.war $KIE_REPOSITORY/org/jbpm/dashboard/jbpm-dashboard-distributions/$KIE_VERSION/jbpm-dashboard-distributions-$KIE_VERSION-$KIE_CLASSIFIER.war && \
unzip -q $HOME/$DASHBUILDER_CONTEXT_PATH.war -d $JBOSS_HOME/standalone/deployments/$DASHBUILDER_CONTEXT_PATH.war &&  \
touch $JBOSS_HOME/standalone/deployments/$DASHBUILDER_CONTEXT_PATH.war.dodeploy &&  \ 
rm -rf $HOME/$DASHBUILDER_CONTEXT_PATH.war

####### MVN REPO ############
# https://bugzilla.redhat.com/show_bug.cgi?id=1263738
RUN mkdir -p $HOME/.m2/repository/org/guvnor/guvnor-asset-mgmt-project/$KIE_VERSION && \
curl -o $HOME/.m2/repository/org/guvnor/guvnor-asset-mgmt-project/$KIE_VERSION/guvnor-asset-mgmt-project-$KIE_VERSION.jar $KIE_REPOSITORY/org/guvnor/guvnor-asset-mgmt-project/$KIE_VERSION/guvnor-asset-mgmt-project-$KIE_VERSION.jar

####### CONFIGURATION ############
USER root
ADD etc/jboss-all.xml $JBOSS_HOME/standalone/deployments/$DASHBUILDER_CONTEXT_PATH.war/META-INF/jboss-all.xml
ADD etc/start_jbpm-wb.sh $JBOSS_HOME/bin/start_jbpm-wb.sh
ADD jbpm-users.properties $JBOSS_HOME/standalone/configuration/
ADD jbpm-roles.properties $JBOSS_HOME/standalone/configuration/
ADD standalone-full.xml $JBOSS_HOME/standalone/configuration/
RUN chown jboss:jboss $JBOSS_HOME/standalone/deployments/*
RUN chown jboss:jboss $JBOSS_HOME/bin/start_jbpm-wb.sh

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

# Expose the ports we're interested in
EXPOSE 8080
EXPOSE 8001
EXPOSE 22

####### CUSTOM JBOSS USER ############
# Switchback to jboss user
# USER jboss

# Set the default command to run on boot
# This will boot WildFly in the standalone mode and bind to all interface
####### RUNNING JBPM-WB ############
#WORKDIR $JBOSS_HOME/bin/
CMD  /run.sh && /opt/jboss/wildfly/bin/start_jbpm-wb.sh 
