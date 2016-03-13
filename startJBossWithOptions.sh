#! /bin/bash

JBOSS_WEB_PATH=/opt/jboss/jboss-eap-6.4/standalone/deployments/business-central.war/WEB-INF/jboss-web.xml
JBOSS_START_SCRIPT=/opt/jboss/jboss-eap-6.4/bin/standalone.sh

echo -e "\n\n================================================\n"

if [ -z ${BC_CONTEXT_ROOT+x} ];
	then
		echo "BC_CONTEXT_ROOT is unset. Using default business-central URL context root."
 	else
 		echo "BC_CONTEXT_ROOT is set. The URL context root will be '$BC_CONTEXT_ROOT'"
 		sed -i "s/<\/security-domain>/<\/security-domain>\n\t<context-root>$BC_CONTEXT_ROOT<\/context-root>/" $JBOSS_WEB_PATH
fi

echo -e "\n===================================================\n\n"

$JBOSS_START_SCRIPT
