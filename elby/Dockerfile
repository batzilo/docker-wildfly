FROM httpd:2.4

# Copy in the modcluster modules
COPY mod_cluster-1.3.1.Final-linux2-x64-so.tar.gz /root/httpd_mod_cluster.tar.gz

# Add the start up script
COPY start_httpd.sh /usr/bin/start_httpd.sh

RUN start_httpd.sh
