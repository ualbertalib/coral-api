#!/bin/bash

echo "Creating new coral_api_prod database / required tables and views / stored procedures"
echo "using root to login....."
cat api_tables.sql | mysql -u root -p
echo "Done"
