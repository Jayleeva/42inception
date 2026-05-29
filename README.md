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
  - The volumes must store their data localy, IN THE HOST MACHINE, at /home/cyglardo/data, despite being NAMED VOLUMES and NOT bind mounts.
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

## Project
- https://tuto.grademe.fr/inception/

## Docker
- https://www.youtube.com/watch?v=GVogBCqrXck&list=PLn6POgpklwWq0iz59-px2z-qjDdZKEvWd
- https://gitlab.com/xavki/docker-v2/-/blob/main/02-premier-pas/premier-pas.sh?ref_type=heads
- file:///D:/Rapport-M437_ServiceConteneurs_GFischer.pdf

## Docker compose
- https://www.appsdeveloperblog.com/docker-compose-tutorial-for-beginners/
- https://maximorlov.com/docker-compose-syntax-volume-or-bind-mount/

## Dockerfile
- https://github.com/vbachele/Inception/blob/main/scrs/requirements/wordpress/Dockerfile
- https://docs.docker.com/get-started/docker-concepts/building-images/

## Bind mount
- https://docs.docker.com/engine/storage/bind-mounts/

## Named volumes
- https://stackoverflow.com/questions/55366386/difference-between-docker-volume-type-bind-vs-volume
- https://www.portainer.io/blog/persistent-storage-docker-bind-mounts-and-named-volumes
- https://stackoverflow.com/questions/47150829/what-is-the-difference-between-binding-mounts-and-volumes-while-handling-persist

## Daemon
- https://www.geeksforgeeks.org/devops/what-is-docker-daemon/
- https://docs.docker.com/engine/daemon/

## PID 1
- https://dev.to/alejiri/docker-nginx-wordpress-mariadb-tutorial-inception42-1eok
- https://www.docker.com/blog/docker-best-practices-choosing-between-run-cmd-and-entrypoint/

## Nginx
- https://www.f5.com/glossary/nginx
- https://medium.com/@vosarat1995/nginx-and-docker-getting-started-d32d9d6cbb95

# Project description
## Uses of Docker and sources included
Docker is used in order to facilitate the passage from developpement to deployement, by making sure that what works in your IDE will also work in prod, since the environment is guaranted to be the same. It also insures that every dev works with the same environment all along.

NGINX is a web server that also works as proxy and API(). It's used to power websites.

WordPress is a () that facilitates the making and maintaining of websites. It's used to make and maintain websites.

MariaDB is a opensource database that came when MYSQL decided to fuck up. It's used to store and access data.

## Main design choices
I chose Debian instead of Alpine because I'm more familiar with the first + I heard on this project it's a nightmare to deal with the dependancies of Alpine.

To answer the riddle of "no bind mounts, but your data must be stored in the host machine", I decided to ().

To respect the instruction "if an entrypoint launches a .sh, the script must NOT launch nginx", and still have a script for nginx since the tree model had a "nginx/tools" directory, I followed the nginx ENTRYPOINT ["nginx.sh"] with a CMD ["nginx"].

## Comparisons

### Virtual Machines vs Docker
Docker is smaller, so it uses less ressources. You build it with strictly what you need instead of an entire machine.

### Secrets vs Environment Variables
Environment variables are accessible and written in clear. Secrets allow, well, secrecy.

### Docker Network vs Host Network
Guessing that docker network is safer than a host network, idk.

### Docker Volumes vs Bind Mounts
Volumes (named or anonymous) store their data localy. Bind mounts allow to take data from the host. Something like that. 