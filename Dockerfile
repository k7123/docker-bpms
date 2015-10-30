FROM sherl0cks/eap:6.4.4


####### MAINTAINER ############
MAINTAINER "Justin Holmes" "jholmes@redhat.com"

####### ENVIRONMENT ############
ENV ARTIFACT_REPOSITORY http://download.eng.bos.redhat.com/brewroot/repos/jb-ip-6.1-build/latest/maven/org/jboss/ip/jboss-bpmsuite
ENV BPMS_VERSION 6.1.4.GA-redhat-2

# Download BPMSuite
RUN cd /opt/jboss/ \
	&& curl -O $ARTIFACT_REPOSITORY/$BPMS_VERSION/jboss-bpmsuite-$BPMS_VERSION-deployable-eap6.x.zip \
	&& unzip -q -o jboss-bpmsuite-$BPMS_VERSION-deployable-eap6.x.zip -d .  \ 
	&& rm jboss-bpmsuite-$BPMS_VERSION-deployable-eap6.x.zip

# Download config files
RUN curl https://raw.githubusercontent.com/sherl0cks/ansible-openstack-etc/master/ansible/files/standalone.conf > $JBOSS_HOME/bin/standalone.conf
RUN curl https://raw.githubusercontent.com/sherl0cks/ansible-openstack-etc/cb56b5eb0b23520960671d818ab94af82f0dece7/ansible/files/application-roles.properties > $JBOSS_HOME/standalone/configuration/application-roles.properties
RUN curl https://raw.githubusercontent.com/sherl0cks/ansible-openstack-etc/cb56b5eb0b23520960671d818ab94af82f0dece7/ansible/files/application-users.properties > $JBOSS_HOME/standalone/configuration/application-users.properties
RUN curl https://raw.githubusercontent.com/sherl0cks/ansible-openstack-etc/master/ansible/files/mgmt-groups.properties > $JBOSS_HOME/standalone/configuration/mgmt-groups.properties 
RUN curl https://raw.githubusercontent.com/sherl0cks/ansible-openstack-etc/master/ansible/files/mgmt-users.properties > $JBOSS_HOME/standalone/configuration/mgmt-users.properties 

EXPOSE 8080 9990 9999 8009 8443 3528 3529 5445 8090 4447 4712 4713 8001 9418

CMD ["/opt/jboss/jboss-eap-6.4/bin/standalone.sh"]
