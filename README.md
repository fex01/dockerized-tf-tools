# dockerized-tf-tools

Playing around with the idea to dockerize project specific runtimes &amp; cli tools - in this case:

- [terraform-cli](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- [aws-cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#cliv2-linux-install)
- [cdktf](https://developer.hashicorp.com/terraform/tutorials/cdktf/cdktf-install)
  - Java (OpenJDK 17)
  - Node.js
  - Maven

## Prerequisites

- Docker

## Usage

- `docker build . -f Dockerfile -t dev-tf` - build image
- `docker run -d --name dev-tf -v /var/run/docker.sock:/var/run/docker.sock dev-tf` - start container
  - volume is required to enable docker in docker scenarios - see also <<https://devopscube.com/run-docker-in-docker/>>
- `docker exec -it dev bash` - connect to container and use bash prompt

## Conclusion

- The [Terraform Getting Started](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)- and the [Build Infrastructure (AWS)](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build)-guide run both just fine with the prepared image.
- The guide [Install CDK for Terraform and Run a Quick Start Demo](https://developer.hashicorp.com/terraform/tutorials/cdktf/cdktf-install) not so much:
  - high cpu usage when executing `cdktf` commands
  - execution of `cdktf provider add kreuzwerker/docker` takes multiple minutes or does not execute at all
  - `cdktf destroy` does always run into `[ERROR] Failed to execute goal org.codehaus.mojo:exec-maven-plugin:3.0.0:java (default-cli) on project learn-cdktf-docker: An exception occured while executing the Java class. Child process exited unexpectedly!` and does not destroy the deployed container
