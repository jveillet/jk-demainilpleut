#!/bin/sh

USERNAME=doctor
USERGROUP=doctor
HOMEDIR=/home/${USERNAME}
UID=$(id -u)
GID=$(id -g)

FILE="
FROM ruby:2.2.4-slim\n
\n
# Define local mirror (if this one fail, just change http://ftp2.fr to http://ftp2.de)\n
RUN echo \"deb http://security.debian.org/ jessie/updates main contrib non-free\" > /etc/apt/sources.list\n
RUN echo \"deb-src http://security.debian.org/ jessie/updates main contrib non-free\" >> /etc/apt/sources.list\n
RUN echo \"deb http://ftp2.fr.debian.org/debian/ jessie main contrib non-free\" >> /etc/apt/sources.list\n
RUN echo \"deb-src http://ftp2.fr.debian.org/debian/ jessie main contrib non-free\" >> /etc/apt/sources.list\n
\n
RUN apt-get clean && apt-get update -y \\ \n
\t\t&& apt-get install -y --no-install-recommends git-core build-essential sudo libffi-dev libxml2-dev libssl-dev python \\ \n
\t\t&& rm -rf /var/lib/apt/lists/*\n
\n
# Add doctor user to sudo group\n
RUN groupadd -f -g ${GID} ${USERGROUP}\n
RUN useradd -m -u ${UID} -g ${USERGROUP} ${USERNAME}\n
RUN echo '%doctor ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers\n
\n
RUN mkdir -p /app\n
RUN mkdir -p /bundle\n
\n
WORKDIR /app\n
\n
COPY Gemfile /app/\n
COPY Gemfile.lock /app/\n
\n
# Give access to doctor user\n
RUN chown -R ${USERNAME}:${USERGROUP} /app\n
RUN chown -R ${USERNAME}:${USERGROUP} /bundle\n
RUN chown -R ${USERNAME}:${USERGROUP} ${HOMEDIR}\n
\n
USER ${USERNAME}\n
\n
# Set bundler config\n
ENV BUNDLE_JOBS=10 \\ \n
    BUNDLE_PATH=/bundle \\ \n
    BUNDLE_APP_CONFIG=/app/.bundle-docker/\n
\n
# throw errors if Gemfile has been modified since Gemfile.lock\n
RUN bundle config\n
RUN bundle install --clean\n
\n
COPY . /app/
"

# Create Dockerfile and put the configuration in it
rm -f Dockerfile
touch Dockerfile
echo ${FILE} >> Dockerfile

# launch the docker environement setup
docker-compose build
