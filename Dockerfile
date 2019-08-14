FROM ubuntu:18.04

LABEL maintainer="devops@brainbeanapps.com"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      apt-transport-https \
      apt-utils \
      build-essential \
      ca-certificates \
      git \
      gnupg \
      locales \
      openssh-client \
      wget \
      zip \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8
    
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

WORKDIR /builds
