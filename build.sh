#!/bin/sh

ECR="189949485192.dkr.ecr.us-east-1.amazonaws.com"
ECR_REPOSITORY="homecooked-backup"
DOCKER_IMAGE_TAG="hc-backup"
# DOCKER_IMAGE_VER="latest"
DOCKER_IMAGE_VER=$(cat version.txt)

echo Logging into AWS ecr
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR

echo Building Docker Image
if ! docker build -t $DOCKER_IMAGE_TAG:$DOCKER_IMAGE_VER . ; then
    echo Build Failed
    exit 1
fi

IMAGEID=$(docker images $DOCKER_IMAGE_TAG:$DOCKER_IMAGE_VER --format {{.ID}})
echo Image built: $IMAGEID

echo Tagged for upload
docker tag $IMAGEID $ECR/$ECR_REPOSITORY

echo Uploading to ECR
if ! docker push $ECR/$ECR_REPOSITORY ; then
    echo Push Failed
    exit 1
fi

echo Clearing images
docker rmi $(docker images $DOCKER_IMAGE_TAG --format {{.ID}}) -f
docker rmi $(docker images $ECR/$ECR_REPOSITORY --format {{.ID}}) -f

