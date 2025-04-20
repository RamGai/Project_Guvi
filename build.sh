#!/bin/bash
 
# Variables
echo "Current Branch: $BRANCH_NAME"
 
if [ "$BRANCH_NAME" == "dev" ]; then
    docker build -t ramgai/dev .
    docker push ramgai/dev:latest
 
elif [ "$BRANCH_NAME" == "main" ]; then
    docker build -t ramgai/prod .
    docker push ramgai/prod:latest
fi