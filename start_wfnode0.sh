# Start the first wildfly container
# Map the host 8081 port to container 8080 port
# Map the host 9991 port to container 9990 port
docker run \
	-p 8081:8080 \
	-p 9991:9990 \
	-h wfnode0 \
	--ip 192.168.42.5 \
	--net wildfly-bridge \
	--add-host wfnode1:192.168.42.10 \
	--add-host elby:192.168.42.2 \
	--name wfnode0 \
	-d \
	wildfly
