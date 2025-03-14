#!/usr/bin/env bash
docker container prune
docker-compose -f /disk1/e/GoProject/docker/php/docker-compose.yml up -d --build 
docker-compose -f /disk1/e/GoProject/docker/monitoring/docker-compose.yml up -d  
docker-compose -f /disk1/e/GoProject/docker/postgresql/docker-compose.yml up -d  
 
