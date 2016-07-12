#! /bin/bash

JBOSS_WEB_PATH_1=/opt/jboss/jboss-eap-6.4/standalone/deployments/business-central.war/WEB-INF/jboss-web.xml
JBOSS_WEB_PATH_2=/opt/jboss/jboss-eap-6.4/standalone/deployments/kie-server.war/WEB-INF/jboss-web.xml
JBOSS_WEB_PATH_3=/opt/jboss/jboss-eap-6.4/standalone/deployments/dashbuilder.war/WEB-INF/jboss-web.xml

JBOSS_START_SCRIPT=/opt/jboss/jboss-eap-6.4/bin/standalone.sh

echo -e "\n\n================================================\n"

if [ -z ${CONTEXT_ROOT_SUFFIX+x} ];
	then
		echo "CONTEXT_ROOT_SUFFIX is unset. Using default business-central URL context root."
 	else
 		echo "CONTEXT_ROOT_SUFFIX is set. The URL context root will be '$CONTEXT_ROOT_SUFFIX'"
 		sed -i "s/<\/security-domain>/<\/security-domain>\n\t<context-root>business-central-$CONTEXT_ROOT_SUFFIX<\/context-root>/" $JBOSS_WEB_PATH_1
 		sed -i "s/<\/security-domain>/<\/security-domain>\n\t<context-root>kie-server-$CONTEXT_ROOT_SUFFIX<\/context-root>/" $JBOSS_WEB_PATH_2
 		sed -i "s/<\/security-domain>/<\/security-domain>\n\t<context-root>dashbuilder-$CONTEXT_ROOT_SUFFIX<\/context-root>/" $JBOSS_WEB_PATH_3
fi

echo -e "\n===================================================\n\n"

$JBOSS_START_SCRIPT
