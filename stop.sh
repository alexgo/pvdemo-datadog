#! /bin/bash

echo "Stopping polyverse_* containers so we allow etcd to migrate state safely."
docker stop $(docker ps -qa -f "name=polyverse_*")

echo "Killing any remaining docker containers..."
docker kill $(docker ps -qa)

echo "Removing any killed docker containers..."
docker rm -v $(docker ps -qa)

