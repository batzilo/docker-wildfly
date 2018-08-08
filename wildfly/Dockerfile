FROM jboss/wildfly:8.2.0.Final

# Add the application in the container
ADD app.war /opt/jboss/wildfly/standalone/deployments/

# Add the start up script
ADD start_wildfly.sh /usr/bin/start_wildfly.sh

# Create a management user
RUN /opt/jboss/wildfly/bin/add-user.sh admin admin --silent

CMD start_wildfly.sh
