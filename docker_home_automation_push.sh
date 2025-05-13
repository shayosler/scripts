#!/bin/bash
# Push a docker image to the home automation registry
image="$1"
project_id=home-automation-459601
registry="home-automation"
new_tag="us-west1-docker.pkg.dev/${project_id}/${registry}/${image}"
docker tag "$image" "$new_tag"
docker push "$new_tag"
