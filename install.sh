#!/bin/sh

USERNAME=doctor
USERGROUP=doctor
HOMEDIR=/home/${USERNAME}
UID=$(id -u)
GID=$(id -g)

FILE="
FROM ruby:2.2.6-slim\n
\n
\n
RUN apt-get clean && apt-get update -y \\ \n
\t\t&& apt-get install -y --no-install-recommends git-core build-essential sudo libffi-dev libxml2-dev libssl-dev python imagemagick libmagickwand-dev curl\\ \n
\t\t&& rm -rf /var/lib/apt/lists/*\n
\n
# Using Debian, as root\n
# Force install latest version of Nodejs\n
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -\n
RUN apt-get install -y nodejs\n
# install globally Gulp\n
RUN /usr/bin/npm install -g gulp\n
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

# Launch the Ruby gems install
docker-compose run --rm blog bundle install

# Install all the node dependencies
docker run -it --rm -v ${PWD}:/app/ jkdemainilpleut_blog npm install
