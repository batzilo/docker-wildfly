# Start the second wildfly container
# Map the host 8082 port to container 8080 port
# Map the host 9992 port to container 9990 port
docker run \
	-p 8082:8080 \
	-p 9992:9990 \
	-h wfnode1 \
	--ip 192.168.42.10 \
	--net wildfly-bridge \
	--add-host wfnode0:192.168.42.5 \
	--add-host elby:192.168.42.2 \
	--name wfnode1 \
	-d \
	wildfly
