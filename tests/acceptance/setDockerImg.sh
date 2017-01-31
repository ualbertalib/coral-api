#!/bin/bash

echo '127.0.0.1 local.coral-api' >> /etc/hosts
cp /src/tests/_envs/coral-api-docker.conf /etc/apache2/sites-available/
rm /etc/apache2/sites-enabled/example.com.conf
cd /etc/apache2/sites-available/
a2ensite coral-api-docker.conf
service apache2 start
service mysql start
mysql --user=root --password=Admin2015 < /src/tests/_data/coral_licensing_prod.sql
mysql --user=root --password=Admin2015 < /src/tests/_data/coral_api_prod.sql
cd /src/sql
for x in $(ls *_sp.sql); do mysql --user=root --password=Admin2015 < $x; done;
cp /src/tests/_envs/docker_credentials.php /src/php/credentials.php

#while true; do
#    sleep 1000
#done
