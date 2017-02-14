#!/bin/bash

echo "Runnig scripts to update data in the database"
echo "using root to login, it will take a minute, please wait....."
cat update.sql | mysql -u root -p
echo "Done"
