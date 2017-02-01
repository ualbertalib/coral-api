#!/bin/bash
echo "loading data into coral_api_prod database tables"
echo "using root to login ....."
cat sfx_load.sql load_link.sql | mysql --database=coral_api_prod  -u root -p
echo "Done"
