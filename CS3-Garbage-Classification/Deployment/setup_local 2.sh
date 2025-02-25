#!/bin/zsh
# ===============================================================
#    Build and push the image to Docker Hub. Create archives 
#                   with data and models
# ===============================================================
# Parameters:
#       None.
# =============================================================== 

# set -x  # Enable command tracing

cd "~/Users/local_user/path/to/project"

# Build a container for amd64 platform and push it to Docker Hub
docker buildx build --platform linux/amd64 -t docker_user_name/garbage-classification-app:latest . && \
docker push docker_user_name/garbage-classification-app:latest

# Create an archive with images dataset if it doesn't exist yet
if [ -f "data.tar.gz" ]; then
    echo "Data archive already exists."
else
    tar --exclude='.*' -czvf data.tar.gz Data
fi

# Create an archive with pretrained models if it doesn't exist yet
if [ -f "models.tar.gz" ]; then
    echo "Models archive already exists."
else
    tar --exclude='.*' -czvf models.tar.gz Models
fi
