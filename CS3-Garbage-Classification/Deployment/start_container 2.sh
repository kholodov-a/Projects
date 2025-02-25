#!/bin/bash
# ===============================================================
#                 Pull and run the docker on a EC2
# ===============================================================
# Parameters:
#       $1: the key tocken for Docker Hub account
#       $2: the shared memory size for the container
# =============================================================== 

set -x

# Update all packages
sudo yum update -y

# Install Docker and start it (AWS has it already installed and started)
sudo yum install -y docker
sudo service docker start

# To check that Docker is launched
# docker info

# adds the user ec2-user to the docker group. By being in the docker group, the user will have the necessary 
# permissions to run Docker commands without needing to use sudo each time.
sudo usermod -aG docker ec2-user

# Login to Docker Hub
echo "$1" | docker login -u docker_user_name --password-stdin

# Download the Docker image from Docker Hub
docker pull docker_user_name/garbage-classification-app:latest && \
docker run --shm-size=$2 --gpus all --volume='/home/ec2-user/garbage_project/Models':/app/Models \
           --volume='/home/ec2-user/garbage_project/Data':/app/Data \
           --workdir=/app -p 8000:8000 -d docker_user_name/garbage-classification-app:latest
