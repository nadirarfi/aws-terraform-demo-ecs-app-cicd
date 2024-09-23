#!/bin/bash


DOCKER_IMAGE_NAME=frontend-todo
APPLICATION_PORT=3000

# Build the Docker image
echo "Building the Docker image..."
docker build -t $DOCKER_IMAGE_NAME .

# Check if the container is already running and stop it
if [ "$(docker ps -q -f name=$DOCKER_IMAGE_NAME-container)" ]; then
    echo "Stopping the existing container..."
    docker stop $DOCKER_IMAGE_NAME-container
fi

# Remove the container if it exists
if [ "$(docker ps -a -q -f name=$DOCKER_IMAGE_NAME-container)" ]; then
    echo "Removing the existing container..."
    docker rm $DOCKER_IMAGE_NAME-container
fi

# Run the Docker container
echo "Running the Docker container..."
docker run -d -p $APPLICATION_PORT:$APPLICATION_PORT --name $DOCKER_IMAGE_NAME-container $DOCKER_IMAGE_NAME

# Display the running container
echo "Container is now running at http://localhost:$APPLICATION_PORT"

# Logs
# docker logs $DOCKER_IMAGE_NAME-container

