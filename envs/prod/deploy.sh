# TODO as for environment
ENVIRONMENT="production"

TF_VAR_environment=$ENVIRONMENT
IMAGE_NAME=backend-$ENVIRONMENT
export TF_VAR_environment
#--------
#docker build ../../project -t terra-python:latest

terraform apply -target aws_ecr_repository.images_repository -auto-approve ../../ 


AWS_ID=$(aws sts get-caller-identity --output text --query 'Account')
docker login -u AWS -p $(aws ecr get-login-password --region us-west-2) https://$AWS_ID.dkr.ecr.us-west-2.amazonaws.com

docker tag $(docker images terra-python:latest -q) $AWS_ID.dkr.ecr.us-west-2.amazonaws.com/$IMAGE_NAME

docker push $AWS_ID.dkr.ecr.us-west-2.amazonaws.com/$IMAGE_NAME:latest

terraform apply -auto-approve  ../../ 
