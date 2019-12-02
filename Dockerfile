FROM ubuntu:bionic

LABEL maintainer="devops@brainbeanapps.com"

# Switch to root
USER root

# Set shell as non-interactive during build
# NOTE: This is discouraged in general, yet we're using it only during image build
ARG DEBIAN_FRONTEND=noninteractive

# Use bash instead of bash
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN dpkg-reconfigure dash 2>&1

# Install base
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    apt-utils \
    apt-transport-https \
    ca-certificates \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    tzdata \
    locales \
    locales-all \
    wget \
    curl \
    zip \
    build-essential \
    git \
    gnupg \
    openssh-client \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Set the locale
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8

# Extra tools
RUN mkdir -p /opt/bin
ENV PATH="/opt/bin:${PATH}"

# Install repo tool
RUN mkdir -p /opt/bin \
  && wget https://storage.googleapis.com/git-repo-downloads/repo -O /opt/bin/repo -q \
  && chmod +x /opt/bin/repo

# Create user and switch to it
RUN useradd -m -s /bin/bash user
USER user
WORKDIR /home/user
