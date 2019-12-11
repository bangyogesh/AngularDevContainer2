#FROM openjdk:8

FROM ubuntu
USER root

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# install git iproute2
RUN apt-get update && apt-get -y install git iproute2

# https support
RUN apt-get install apt-transport-https

# get gcc
RUN apt-get update &&apt-get install build-essential -y

#curl install
RUN apt-get -y install curl

# Install Node.js v10-stable
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs

# Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - 2>/dev/null \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install yarn=1.13.0-1
	
# Install typescript, angular cli
RUN npm install -g tslint typescript ng @angular/cli

# Clean up
RUN apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
	
# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=
USER root
