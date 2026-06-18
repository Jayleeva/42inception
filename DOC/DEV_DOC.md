# Developer-oriented instructions 

## Prerequisites
Your host machine must be able to run the VM.

## Setup
You must give the stack a .env file containing every environment variable used in the different .sh scripts. You are free to modify their values at will. This file is gitignored, so it will never be pushed.

Here's an example of .env:
````
MYSQL_USER=insertUSERhere
MYSQL_PASSWORD=insertPASSWORDhere
MYSQL_ROOT_PASSWORD=insertROOTPASSWORDhere

MYSQL_HOSTNAME=wordpress
MYSQL_DATABASE=mariadb

DOMAIN_NAME=cyglardo.42.fr
TITLE=inception

WP_ADMIN_USER=insertUSERhere
WP_ADMIN_PASSWORD=insertPASSWORDhere
WP_ADMIN_EMAIL=insertEMAILhere

WP_USER=insertUSERhere
WP_PASSWORD=insertPASSWORDhere
WP_EMAIL=insertEMAILhere
````

You must give the stack an empty secrets/ repository. This will store the SSL certificate and private key. This repository is gitignored, so it will never be pushed.

## Makefile usage
Once you're set up, start the stack with ``make``. 

To stop the stack, use ``make down``.
To restart it, use ``make up``.

Do not use ``make fclean`` or ``make re`` unless you want to delete every volume(, the .env file) and the secrets files.

You can use ``make clean`` ???

You can use ``backup`` in order to copy the content of the data repository. It is called by ``make fclean`` by default, were you to use it by accident.

## Docker compose commands
Please do not use any docker compose commands.

## Data persistence
You can restart the stack or even the VM and data will persist, as long as you don't ``make fclean``, or use direct commands to ``prune``.