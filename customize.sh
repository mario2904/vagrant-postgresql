#!/usr/bin/env bash

set -e
set -u

# Edit the following to change the name of the database user that will be created:
APP_DB_USER=$USER
APP_DB_PASS=$USER

# Edit the following to change the name of the database that is created (defaults to the user name)
APP_DB_NAME=$APP_DB_USER

################################################################################
#                           SETUP USER/PASS                                    #
################################################################################
# Create user
sudo -u postgres createuser --superuser $APP_DB_USER

# Create db
sudo -u $APP_DB_USER createdb $APP_DB_NAME

# Set password
sudo -u postgres psql -c "ALTER USER $APP_DB_USER WITH PASSWORD '$APP_DB_PASS';"

################################################################################
#                           CREATE TABLES                                      #
################################################################################
RUN_ON_MYDB="psql -X -U $APP_DB_USER --set ON_ERROR_STOP=on --set AUTOCOMMIT=off $APP_DB_NAME"

$RUN_ON_MYDB <<SQL
create table foo (bar varchar(20));
commit;
SQL
