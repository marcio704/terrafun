docker build ./project -t terra-python:latest

terraform apply -target aws_ecr_repository.image_repository -auto-approve

docker login -u AWS -p $(aws ecr get-login-password --region us-west-2) https://132545038717.dkr.ecr.us-west-2.amazonaws.com

docker tag $(docker images terra-python:latest -q) 132545038717.dkr.ecr.us-west-2.amazonaws.com/terra_images

docker push 132545038717.dkr.ecr.us-west-2.amazonaws.com/terra_images:latest

# terraform apply -target aws_ecs_task_definition.task-definition-test -target aws_ecs_service.service -auto-approve

terraform apply -auto-approve
