*This project has been created as part of the 42 curriculum by cyglardo.*

# Description
Take a first dive into infrastructure by making multiple Docker images work together.

Each image does its own thing and can communicate with its neighbour, in a "cascade" (A with B, B with C, C with B, B with A), via a docker-network.

- First image is a NGINX container.
- Second is a WordPress + PHP container.
- Last is a MariaDB (database) container.

We must have 2 volumes :
- storage of the database, accessible to MariaDB
- storage of the website files, accessible to both NGINX and WordPress

The project asks that we build our own Docker images. We must then write our own dockerfiles, which will be called in the docker-compose.yml of our Makefile.

In addition to every files needed for the project to work, we must also produce a USER_DOC.md and a DEV_DOC.md: the first one is meant for users who just need to know what they can do with the project and how to do it, and the second is meant for developers who might need to reset it, understand its data storage or manage the containers and volumes.

**CAREFUL**
  - A DOCKER IS NOT A VIRTUAL MACHINE. We're using multiple Docker images on one virtual machine.
  - The project will contain some information that must stay private (credentials, API keys, passwords,...), meaning strictly stored in local files and NEVER pushed on git.
  - Are prohibited: tail -f, bash, sleep infinity, while true. WE CAN'T USE AN INFINITE LOOP.
  - The volumes must store their data localy, ON THE HOST MACHINE, at /home/cyglardo/data, despite being NAMED VOLUMES and NOT bind mounts.
  - If any container crashes, it must restart.

Pour répondre à tous les critères: utiliser un daemon (automatique avec Docker), et configurer le data root du Docker daemon dans la VM pour qu'elle pointe vers /home/login/data. Comme ça, pas besoin de bind mount ou de bricolage avec driver_opts, et les volumes sont nommés quelque part (named) et pas juste désignés par un chemin.
- docker run -v /home/cyglardo/data

# Instructions
- docker ps -a
- docker run -d --name c1 nginx:latest (!!latest PROHIBITED!!)
- docker exec -ti c1 bash (!!bash PROHIBITED!!)
- docker volume ls

# Ressources

## AI use
None.

## Docker
- https://www.youtube.com/watch?v=GVogBCqrXck&list=PLn6POgpklwWq0iz59-px2z-qjDdZKEvWd
- https://gitlab.com/xavki/docker-v2/-/blob/main/02-premier-pas/premier-pas.sh?ref_type=heads
- https://docs.docker.com/get-started/workshop/
- file:///D:/Rapport-M437_ServiceConteneurs_GFischer.pdf

## Docker compose
- https://www.appsdeveloperblog.com/docker-compose-tutorial-for-beginners/

## Dockerfile
- https://docs.docker.com/get-started/docker-concepts/building-images/writing-a-dockerfile/

## Difference between bind mount and volume mount
- https://maximorlov.com/docker-compose-syntax-volume-or-bind-mount/
- https://stackoverflow.com/questions/55366386/difference-between-docker-volume-type-bind-vs-volume
- https://www.portainer.io/blog/persistent-storage-docker-bind-mounts-and-named-volumes
- https://stackoverflow.com/questions/47150829/what-is-the-difference-between-binding-mounts-and-volumes-while-handling-persist

## Named volumes that store data in specific host path (bind-like, but not bind)
- https://oneuptime.com/blog/post/2026-02-08-how-to-use-docker-local-volume-driver-with-custom-options/view

## Daemon
- https://www.geeksforgeeks.org/devops/what-is-docker-daemon/
- https://docs.docker.com/engine/daemon/

## PID 1: RUN, ENTRYPOINT OR CMD ?
- https://www.docker.com/blog/docker-best-practices-choosing-between-run-cmd-and-entrypoint/

## Nginx
- https://www.f5.com/glossary/nginx
- https://medium.com/@vosarat1995/nginx-and-docker-getting-started-d32d9d6cbb95

## WordPress
- https://www.ibm.com/think/topics/wordpress
- https://ubuntu.com/tutorials/install-and-configure-wordpress#6-configure-wordpress-to-connect-to-the-database

## PHP
- https://www.reddit.com/r/AskProgramming/comments/191g5b9/what_is_php_and_why_do_i_need_to_learn_it/
- https://kinsta.com/blog/what-is-php/

## MariaDB
- https://www.one.com/en-gb/hosting/what-is-mariadb/
- https://mariadb.com/docs/server/server-management/install-and-upgrade-mariadb/configuring-mariadb/configuring-mariadb-with-option-files

# Project description
## Uses of Docker and sources included
Docker is used in order to facilitate the passage from developpement to deployement, by making sure that what works in your IDE will also work in prod, since the environment is guaranted to be the same. It also insures that every dev works with the same environment all along.

NGINX is a web server that can also work as reverse proxy, load balancing, API gateway, and more. It's used to host websites.

WordPress is a web content managment system. It's used to make and maintain websites.

PHP is a language used by WordPress for its capacity to work with databases, which allows it to generate HTML dynamically.

MariaDB is a opensource database that forked from MYSQL. It's used to store and access data.

## Main design choices
I chose Debian instead of Alpine because I'm more familiar with the first + I heard on this project it's a nightmare to deal with the dependancies of Alpine.

As it's just a school project on a VM, I thought at first it wasn't so bad if the daemon was on. I decided to disable it in the end in order to follow best safety practice.

I included the secrets/ directory on the .gitignore to stop it from ever being pushed online.

To avoid any infinite loop or bash uses, and to create as few layers as possible for every image, I decided to write scripts (less RUN commands, meaning less layers) and launch them with docker commands like ENTRYPOINT or CMD. To respect the instruction "if an entrypoint launches a .sh, the script must NOT launch nginx or bash", and still have a script for nginx since the tree model had a "nginx/tools" directory, I followed the nginx ENTRYPOINT ["nginx.sh"] with a CMD ["nginx"]. Same concept with WordPress where I launched a configuration script with ENTRYPOINT and then launched PHP with CMD. The WordPress script has a sleep of 10 to make sure the database has time to start first; plus, it does not reconfigure if it's already been done. MariaDB also has that last protection, using -e with every setting command? 

To answer the riddle of "no bind mounts, but your data must be stored in the host machine", I first wanted to modify the root directory of the daemon, allowing me to create simple named volumes that would automatically be stored where we want it. But I wasn't sure how to pull it off, especially if I was expected to disable the daemon, so I ended up doing what everyone did: using the new feature "bind-mount style named volumes". Basically, you create a named volume, but by specifiying the driver_opts with type = none, o = bind, and device = your/host/directory, you mount it in a bind way. In order for this to work, I had to make sure the host directory exists before creating the volume.

I chose to use "on-failure" instead of "always" for the restart option of each container because to me it's what corresponds best to the instruction "must restart on failure".


## Comparisons

### Virtual Machines vs Docker
Docker is smaller, so it uses less ressources. You build it with strictly what you need instead of an entire machine.

### Secrets vs Environment Variables
Environment variables are accessible and written in clear. Secrets allow, well, secrecy.

### Docker Network vs Host Network
Guessing that docker network is safer than a host network, idk.

### Docker Volumes vs Bind Mounts
Volumes (named or anonymous) store their data localy. Bind mounts allow to take data from the host. Something like that. 