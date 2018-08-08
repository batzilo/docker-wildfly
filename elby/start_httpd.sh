set -e

tar -zxvf /root/httpd_mod_cluster.tar.gz -C /usr/local/apache2/modules/

cat <<EOF >> /usr/local/apache2/conf/httpd.conf
ServerName elby

# LogLevel debug

LoadModule proxy_module modules/mod_proxy.so
LoadModule proxy_ajp_module modules/mod_proxy_ajp.so
LoadModule cluster_slotmem_module modules/mod_cluster_slotmem.so
LoadModule manager_module modules/mod_manager.so
LoadModule proxy_cluster_module modules/mod_proxy_cluster.so
LoadModule advertise_module modules/mod_advertise.so

<IfModule manager_module>
    AllowDisplay On

    Listen 192.168.42.2:7777
    ManagerBalancerName cluster

    <VirtualHost 192.168.42.2:7777>
        # This is where the application servers talk to
        <Location />
            Require all granted
        </Location>

        KeepAliveTimeout 300
        MaxKeepAliveRequests 0

        ServerAdvertise On
        AdvertiseFrequency 5
        AdvertiseGroup 230.1.1.17:23364
        EnableMCPMReceive

        # This is where the browser console talks to
        <Location /mod_cluster_manager>
            SetHandler mod_cluster-manager
            Require all granted
        </Location>

    </VirtualHost>
</IfModule>

Listen 192.168.42.2:8080

<VirtualHost 192.168.42.2:8080>
    # This is where the browser application talks to
    <Location />
        Require all granted
    </Location>
    ProxyPass / balancer://cluster/
</VirtualHost>
EOF
