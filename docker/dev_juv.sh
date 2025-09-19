#!/bin/bash

# Script to run Jupyter Notebook container
CONTAINER_NAME="chirpstack_pc"
PORT="8888"
NOTEBOOKS_DIR="$HOME/jupyter-notebooks"

# Create notebooks directory if it doesn't exist
mkdir -p "$NOTEBOOKS_DIR"

# Build the image (if not already built)
# echo "Building Docker image..."
# docker build -t $CONTAINER_NAME .

# Stop and remove any existing container with the same name
echo "Stopping any existing container..."
docker stop $CONTAINER_NAME 2>/dev/null
docker rm $CONTAINER_NAME 2>/dev/null

# Run the container
echo "Starting Jupyter Notebook container..."
docker run -it \
    --rm \
    -p 8888:8888 \
    -v $(pwd)/notebooks:/notebooks $CONTAINER_NAME

# docker run -d \
#     --name $CONTAINER_NAME \
#     -p $PORT:8888 \
#     -v "$NOTEBOOKS_DIR:/notebooks" \
#     $CONTAINER_NAME

# # Wait a moment for Jupyter to start
# sleep 3

# # Get the access token
# echo "Getting Jupyter access token..."
# docker logs $CONTAINER_NAME 2>&1 | grep -o "token=[a-zA-Z0-9]*" | head -1

# echo "Jupyter Notebook is running!"
# echo "Access it at: http://localhost:$PORT"
# echo "Notebooks are stored in: $NOTEBOOKS_DIR"