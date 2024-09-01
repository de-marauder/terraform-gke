#!/bin/bash

# build
docker build -t your-dockerhub-username/api-time .

# push
docker push your-dockerhub-username/api-time

# run
docker run --name api-time -p 8080:8080 your-dockerhub-username/api-time

# test
curl localhost:8080
