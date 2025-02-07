#!/usr/bin/fish

# Object type
$1=deployment

# K8s Container name
$2=todos-frontend-deployment

# K8s container image name
$3=todos-frontend

# Docker New image to use
$4=woragis/todos-frontend:v4

kubectl set image $1/$2 $3=$4
