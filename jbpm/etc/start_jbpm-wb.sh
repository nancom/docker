#!/usr/bin/env bash

# Start Wildfly with the given arguments.
echo "Running jBPM Workbench on JBoss Wildfly..."
exec /opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0 -c standalone-full.xml -Dorg.kie.demo=false -Dorg.kie.example=false
exit $?
