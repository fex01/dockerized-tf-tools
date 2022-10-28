FROM amd64/ubuntu:latest

RUN apt-get -qq update \
  && apt-get install -y --no-install-recommends \
  wget
RUN apt-get update \
  && apt-get install -y vim \
  && apt-get install -y tree \
  && apt-get install -y curl \
  && apt-get install -y unzip

# terraform-cli
RUN apt-get install -y gnupg software-properties-common
RUN wget -O- https://apt.releases.hashicorp.com/gpg | \
  gpg --dearmor | \
  tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
  https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
  tee /etc/apt/sources.list.d/hashicorp.list
RUN apt update \
  && apt-get install terraform
RUN touch ~/.bashrc
RUN terraform -install-autocomplete

# aws-cli
RUN apt-get install -y glibc-source && apt-get install -y groff && apt-get install -y less
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install
RUN rm -Rf awscliv2.zip

# cdktf & java
RUN curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh
RUN bash /tmp/nodesource_setup.sh
RUN apt-get install -y nodejs \
  && apt-get install -y openjdk-17-jre \
  && apt-get install -y maven
RUN npm install --global cdktf-cli@latest

ENTRYPOINT ["tail", "-f", "/dev/null"]