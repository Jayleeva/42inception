*This project has been created as part of the 42 curriculum by cyglardo.*

# Description
Take a first dive into infrastructure by making multiple Docker images work together.

Each image does its own thing and can communicate with its neighbour, in a "cascade" (A with B, B with C, C with B, B with A), via a docker-network.

- First image is a NGINX container.
- Second is a WordPress + PHP container.
- Last is a DATABASE container.

We must have 2 volumes :
- storage of the DATABASE
- storage of the website files

The project asks that we build our own Docker images. We must then write our own dockerfiles, which will be called in the docker-compose.yml of our Makefile.

In addition to every files needed for the project to work, we must also produce a USER_DOC.md and a DEV_DOC.md: the first one is meant for users who just need to know what they can do with the project and how to do it, and the second is meant for developers who might need to reset it, understand its data storage or manage the containers and volumes.

**CAREFUL**
  - A DOCKER IS NOT A VIRTUAL MACHINE. We're using multiple Docker images on one virtual machine.
  - The project will contain some information that must stay private (credentials, API keys, passwords,...), meaning strictly stored in local files and NEVER pushed on git.
  - Are prohibited: tail -f, bash, sleep infinity, while true. WE CAN'T USE AN INFINITE LOOP.
  - The volumes must store their data localy, IN THE HOST MACHINE, at /home/cyglardo/data.
  - If any container crashes, it must restart.


# Instructions

# Ressources

## Docker
- https://www.youtube.com/watch?v=GVogBCqrXck&list=PLn6POgpklwWq0iz59-px2z-qjDdZKEvWd

## Docker compose
- https://www.appsdeveloperblog.com/docker-compose-tutorial-for-beginners/
- https://maximorlov.com/docker-compose-syntax-volume-or-bind-mount/



# Project description
use of Docker and the sources included in the project.

Main design choices

Comparisons between:
  - Virtual Machines vs Docker
  - Secrets vs Environment Variables
  - Docker Network vs Host Network
  - Docker Volumes vs Bind Mounts
