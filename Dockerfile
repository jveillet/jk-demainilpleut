FROM ruby:2.6.1

# Environment variables
# Defaults can be changed in the docker-compose file
ARG RACK_ENV=development
ARG JEKYLL_ENV=development
ARG NODE_ENV=development

# Environment variables
ENV DEBIAN_FRONTEND noninteractive
ENV APP_HOME=/home/doctor/demainilpleut
ENV BUNDLE_APP_CONFIG=$APP_HOME/.bundle/
ENV BUNDLE_JOBS=10
ENV GEM_HOME="/usr/local/bundle"
ENV PATH $GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH

# Create the home directory for the new app user.
RUN mkdir -p $APP_HOME

# Fetch the last version of Nodejs
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

# Install essentials softwares whith dev headers
RUN apt-get clean \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
    build-essential \
    sudo \
    libffi-dev \
    libssl-dev \
    libxml2-dev \
    libcurl4-gnutls-dev \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install the last bundler version
# It is not available with the Heroku image
RUN gem install bundler:1.17.3 --no-document

# Install Gulp
RUN npm install --global gulp-cli

# Create a new user with sudo powers
RUN useradd -ms /bin/bash doctor
RUN echo '%doctor ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Copy local files to the container and apply rights to the user
COPY --chown=doctor:doctor . $APP_HOME/
RUN chown -hR doctor:doctor /home/doctor/

# Move to the application folder
WORKDIR $APP_HOME

# Use custom user
USER doctor

# Copy the files needed for bundler
COPY --chown=doctor:doctor Gemfile* $APP_HOME/

# Install Bundler dependencies
RUN bundle config
RUN bundle install

# Copy the files needed for NPM
COPY --chown=doctor:doctor package* $APP_HOME/

# Install local NPM dependencies
RUN npm install

EXPOSE 4000

RUN unset BUNDLE_PATH
RUN unset BUNDLE_BIN

ENTRYPOINT ["bundle", "exec"]

CMD ["jekyll", "build"]
