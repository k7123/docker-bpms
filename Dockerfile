FROM sherl0cks/eap:6.4.4

####### MAINTAINER ############
MAINTAINER "Justin Holmes" "jholmes@redhat.com"


####### INSTALL PACKAGES ####### 
USER root
RUN yum install -y git && yum clean all
USER jboss


####### BPMS ARTIFACT #######
ENV ARTIFACT_REPOSITORY http://download.eng.bos.redhat.com/brewroot/repos/jb-ip-6.1-build/latest/maven/org/jboss/ip/jboss-bpmsuite
ENV BPMS_VERSION 6.1.4.GA-redhat-2

RUN cd /opt/jboss/ \
	&& curl -O $ARTIFACT_REPOSITORY/$BPMS_VERSION/jboss-bpmsuite-$BPMS_VERSION-deployable-eap6.x.zip \
	&& unzip -q -o jboss-bpmsuite-$BPMS_VERSION-deployable-eap6.x.zip -d .  \ 
	&& rm jboss-bpmsuite-$BPMS_VERSION-deployable-eap6.x.zip


####### EAP CONFIG #######
RUN curl https://raw.githubusercontent.com/sherl0cks/ansible-openstack-etc/cb56b5eb0b23520960671d818ab94af82f0dece7/ansible/files/application-roles.properties > $JBOSS_HOME/standalone/configuration/application-roles.properties
RUN curl https://raw.githubusercontent.com/sherl0cks/ansible-openstack-etc/cb56b5eb0b23520960671d818ab94af82f0dece7/ansible/files/application-users.properties > $JBOSS_HOME/standalone/configuration/application-users.properties
RUN curl https://raw.githubusercontent.com/sherl0cks/ansible-openstack-etc/master/ansible/files/mgmt-groups.properties > $JBOSS_HOME/standalone/configuration/mgmt-groups.properties 
RUN curl https://raw.githubusercontent.com/sherl0cks/ansible-openstack-etc/master/ansible/files/mgmt-users.properties > $JBOSS_HOME/standalone/configuration/mgmt-users.properties 


####### MAVEN CONFIG #######
RUN mkdir -p /opt/jboss/.m2 \
	&& curl https://raw.githubusercontent.com/sherl0cks/ansible-openstack-etc/852ff4a423b147eab7d2025e51e0294214676c20/ansible/files/settings.xml > /opt/jboss/.m2/settings.xml


####### JAVA_OPTS #######
ENV JAVA_OPTS -Dkie.maven.settings.custom=/opt/jboss/.m2/settings.xml \
	-Djboss.bind.address=0.0.0.0 \
	-Djboss.bind.address.management=0.0.0.0 \
    -Dorg.uberfire.nio.git.daemon.host=0.0.0.0 \
	-Dorg.uberfire.nio.git.ssh.host=0.0.0.0 \
	-Djava.security.egd=file:/dev/./urandom


####### PORTS #######
EXPOSE 8080 9990 9418 8001

CMD ["/opt/jboss/jboss-eap-6.4/bin/standalone.sh"]
