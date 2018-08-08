# Start the load balancer
# Map the host 8080 port to container 80 port
# Map the host 7777 port to container 7777 port
docker run \
	-p 8080:8080 \
	-p 7777:7777 \
	-h elby \
	--ip 192.168.42.2 \
	--net wildfly-bridge \
	--add-host wfnode0:192.168.42.5 \
	--add-host wfnode1:192.168.42.10 \
	--name elby \
	-d \
	elby
