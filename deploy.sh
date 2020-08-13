docker build . -t terra-python:latest

$(aws ecr get-login --region 'us-west-2' --no-include-email)

docker tag $(docker images terra-python:latest -q) 455482506963.dkr.ecr.us-west-2.amazonaws.com/terra_images

docker push 455482506963.dkr.ecr.us-west-2.amazonaws.com/terra_images:latest


terraform apply -target aws_ecs_task_definition.task-definition-test -target aws_ecs_service.service