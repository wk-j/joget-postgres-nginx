#!/bin/bash
image="joget"
user="wearetherock"
version="6.0.20"

docker build -t ${image}:latest .

docker tag  ${image}:latest ${user}/${image}:${version}
docker tag  ${image}:latest ${user}/${image}:latest

docker push ${user}/${image}:${version}
docker push ${user}/${image}:latest