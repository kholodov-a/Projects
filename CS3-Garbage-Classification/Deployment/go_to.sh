#!/bin/zsh
# ===============================================================
#   Setup docker image, data and models on the EC2 instance 
# ===============================================================
# Parameters:
#       $1: the instance ip-adress or DNS-name
# =============================================================== 

set -x

target_path="/home/ec2-user/garbage_project"
key_pair="./Deployment/key_pair_for_the_project.pem" 
home_path="~/Users/local_user/path/to/project"

cd $home_path

# To ensure that my key pair is not seen publically
chmod 400 $key_pair

# Make the folder
ssh -o StrictHostKeyChecking=no -i $key_pair ec2-user@$1 "mkdir -p $target_path"

# Copy the archives and the script from S3 bucket to EC2 
ssh -i $key_pair ec2-user@$1 "aws s3 cp s3://capstone3bucket/data.tar.gz $target_path/"
ssh -i $key_pair ec2-user@$1 "aws s3 cp s3://capstone3bucket/models.tar.gz $target_path/"

scp -i $key_pair -r "$home_path/Deployment/start_container.sh" ec2-user@$1:$target_path/ 

# Unpack the archives with the dataset and the models
ssh -i $key_pair ec2-user@$1 "tar -xzvf $target_path/models.tar.gz -C $target_path"
ssh -i $key_pair ec2-user@$1 "tar -xzvf $target_path/data.tar.gz -C $target_path"

# Delete service files created by macOS
ssh -i $key_pair ec2-user@$1 "find $target_path/Data -type f -name '._*' -delete"

# Set execution right for the script file
ssh -i $key_pair ec2-user@$1 "chmod +x $target_path/start_container.sh"

# Login into my EC2 instance
ssh -i $key_pair ec2-user@$1
