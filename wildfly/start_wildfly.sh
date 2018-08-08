set -e

FILE=/opt/jboss/wildfly/standalone/configuration/standalone-ha.xml

# Set a valid node identifier
OLD='<core-environment>'
NEW='<core-environment node-identifier=\"'`cat /proc/sys/kernel/random/uuid | cut -d '-' -f 1`'\">'
sed -i "s#$OLD#$NEW#g" $FILE

# Set the multicast address used by wildfly servers to talk to each other
OLD='<socket-binding name="jgroups-mping" port="0" multicast-address="${jboss.default.multicast.address:230.0.0.4}" multicast-port="45700"/>'
NEW='<socket-binding name="jgroups-mping" port="0" multicast-address="230.1.1.42" multicast-port="45700"/>'
sed -i "s#$OLD#$NEW#g" $FILE

OLD='<socket-binding name="jgroups-udp" port="55200" multicast-address="${jboss.default.multicast.address:230.0.0.4}" multicast-port="45688"/>'
NEW='<socket-binding name="jgroups-udp" port="55200" multicast-address="230.1.1.42" multicast-port="45688"/>'
sed -i "s#$OLD#$NEW#g" $FILE

# Set the multicast address used by wildfly servers to talk to httpd mod cluster
OLD='<socket-binding name="modcluster" port="0" multicast-address="224.0.1.105" multicast-port="23364"/>'
NEW='<socket-binding name="modcluster" port="0" multicast-address="230.1.1.17" multicast-port="23364"/>'
sed -i "s#$OLD#$NEW#g" $FILE

# Start in standalone mode
/opt/jboss/wildfly/bin/standalone.sh -c standalone-ha.xml -b=$HOSTNAME -bmanagement=$HOSTNAME -Djboss.node.name=$HOSTNAME
