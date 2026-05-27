*This project has been created as part of the 42 curriculum by cyglardo.*

# Description
Take a first dive into infrastructure by making multiple Docker images work together.

Each image does its own thing and can communicate with its neighbour, in a "cascade" (A with B, B with C, C with B, B with A), via a docker-network.

- First image is a NGINX container.
- Second is a WordPress + PHP container.
- Last is a MariaDB (database) container.

We must have 2 volumes :
- storage of the database
- storage of the website files

The project asks that we build our own Docker images. We must then write our own dockerfiles, which will be called in the docker-compose.yml of our Makefile.

In addition to every files needed for the project to work, we must also produce a USER_DOC.md and a DEV_DOC.md: the first one is meant for users who just need to know what they can do with the project and how to do it, and the second is meant for developers who might need to reset it, understand its data storage or manage the containers and volumes.

**CAREFUL**
  - A DOCKER IS NOT A VIRTUAL MACHINE. We're using multiple Docker images on one virtual machine.
  - The project will contain some information that must stay private (credentials, API keys, passwords,...), meaning strictly stored in local files and NEVER pushed on git.
  - Are prohibited: tail -f, bash, sleep infinity, while true. WE CAN'T USE AN INFINITE LOOP.
  - The volumes must store their data localy, IN THE HOST MACHINE, at /home/cyglardo/data.
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
- file:///D:/Rapport-M437_ServiceConteneurs_GFischer.pdf

## Docker compose
- https://www.appsdeveloperblog.com/docker-compose-tutorial-for-beginners/
- https://maximorlov.com/docker-compose-syntax-volume-or-bind-mount/

## Dockerfile
- https://github.com/vbachele/Inception/blob/main/scrs/requirements/wordpress/Dockerfile

## Daemon
- https://www.geeksforgeeks.org/devops/what-is-docker-daemon/
- https://docs.docker.com/engine/daemon/

## Nginx
- https://www.f5.com/glossary/nginx
- https://medium.com/@vosarat1995/nginx-and-docker-getting-started-d32d9d6cbb95

# Project description
use of Docker and the sources included in the project.

Main design choices

Comparisons between:
  - Virtual Machines vs Docker
  - Secrets vs Environment Variables
  - Docker Network vs Host Network
  - Docker Volumes vs Bind Mounts
