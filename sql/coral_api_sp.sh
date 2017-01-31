#!/bin/bash

echo "Creating  stored procedures"
echo "using root to login....."
cat coral_api_sp.sql | mysql -u root -p
echo "Done"

