# Remove previous containers
docker container stop -t 0 wfnode0 wfnode1 elby
docker container rm wfnode0 wfnode1 elby

# Remove previous images
docker image rm elby
docker image rm wildfly

# Remove previous network
docker network rm wildfly-bridge

set -e

# Build the web application
cd app
mvn package
cd ..
cp app/target/app-1.0-SNAPSHOT.war app.war

# Build the wildfly docker image
cp app.war wildfly/
cd wildfly
docker build --tag=wildfly .
cd ..

# Build the elby docker image
cd elby
docker build --tag=elby .
cd ..

# Create the docker network
docker network create \
	--driver=bridge \
	--subnet=192.168.42.0/28 \
	--ip-range=192.168.42.0/28 \
	--gateway=192.168.42.1 \
	wildfly-bridge

# Start the docker containers
./start_elby.sh
./start_wfnode0.sh
./start_wfnode1.sh
