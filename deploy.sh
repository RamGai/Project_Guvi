#!/bin/bash
 # Variables
echo "Deployment Branch:$BRANCH_NAME"
docker stop my-react-app || true
docker rm my-react-app || true
if  [ "$BRANCH_NAME" = "dev" ]; then
docker pull ramgai/dev:latest
docker run -d -p 80:80 --name my-react-app ramgai/dev:latest
elif  [ "$BRANCH_NAME" = "main" ]; then
docker pull ramgai/prod:latest
docker run -d -p 80:80 --name my-react-app ramgai/prod:latest
fi
echo "Deployment completed successfully."
