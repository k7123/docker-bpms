FROM sherl0cks/eap:6.4.4

####### MAINTAINER ############
MAINTAINER "Justin Holmes" "jholmes@redhat.com"


####### INSTALL PACKAGES ####### 
USER root
RUN yum install -y git && yum clean all
USER jboss


####### BPMS ARTIFACT #######
ENV ARTIFACT_REPOSITORY http://dev138.mw.lab.eng.bos.redhat.com/candidate
ENV BPMS_VERSION 6.2.0.ER5

RUN cd /opt/jboss/ \
	&& curl -O $ARTIFACT_REPOSITORY/bpmsuite-$BPMS_VERSION/jboss-bpmsuite-$BPMS_VERSION-deployable-eap6.x.zip \
	&& unzip -q -o jboss-bpmsuite-$BPMS_VERSION-deployable-eap6.x.zip -d .  \ 
	&& rm jboss-bpmsuite-$BPMS_VERSION-deployable-eap6.x.zip


####### EAP CONFIG #######
RUN curl https://raw.githubusercontent.com/sherl0cks/ansible-openstack-etc/cb56b5eb0b23520960671d818ab94af82f0dece7/ansible/files/application-roles.properties > $JBOSS_HOME/standalone/configuration/application-roles.properties
RUN curl https://raw.githubusercontent.com/sherl0cks/ansible-openstack-etc/cb56b5eb0b23520960671d818ab94af82f0dece7/ansible/files/application-users.properties > $JBOSS_HOME/standalone/configuration/application-users.properties
RUN curl https://raw.githubusercontent.com/sherl0cks/ansible-openstack-etc/master/ansible/files/mgmt-groups.properties > $JBOSS_HOME/standalone/configuration/mgmt-groups.properties 
RUN curl https://raw.githubusercontent.com/sherl0cks/ansible-openstack-etc/master/ansible/files/mgmt-users.properties > $JBOSS_HOME/standalone/configuration/mgmt-users.properties 


####### MAVEN CONFIG #######
RUN mkdir -p /opt/jboss/.m2 \
	&& curl https://raw.githubusercontent.com/sherl0cks/ansible-openstack-etc/44c9115b6a8bce3c8a39b76520fcd96edc58b73c/ansible/files/settings.xml > /opt/jboss/.m2/settings.xml


####### JAVA_OPTS #######
ENV JAVA_OPTS -Dkie.maven.settings.custom=/opt/jboss/.m2/settings.xml \
	-Djboss.bind.address=0.0.0.0 \
	-Djboss.bind.address.management=0.0.0.0 \
	-Djava.security.egd=file:/dev/./urandom


####### PORTS #######
EXPOSE 8080 9990 9418 8001

CMD ["/opt/jboss/jboss-eap-6.4/bin/standalone.sh"]
