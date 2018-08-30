FROM heroku/heroku:16

# Environment variables
ENV DEBIAN_FRONTEND noninteractive
ENV APP_HOME=/home/doctor/demainilpleut
ENV RACK_ENV=development
ENV JEKYLL_ENV=development
ENV BUNDLE_APP_CONFIG=$APP_HOME/.bundle/
ENV BUNDLE_JOBS=10

# Create the home directory for the new app user.
RUN mkdir -p $APP_HOME

# Copy the files needed for bundler and NPM
COPY Gemfile* $APP_HOME/
COPY package* $APP_HOME/
COPY .env $APP_HOME/

# Fetch the last version of Nodejs 8
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

# Install essentials softwares whith dev headers
RUN apt-get clean \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
    build-essential \
    ruby2.3-dev \
    sudo \
    libffi-dev \
    libssl-dev \
    libxml2-dev \
    libcurl4-gnutls-dev \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install the last bundler version
# It is not available with the Heroku image
RUN gem install bundler --no-ri --no-rdoc

# Install Gulp
RUN npm install --global gulp-cli

# Create a new user with sudo powers
RUN useradd -ms /bin/bash doctor
RUN echo '%doctor ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Copy local files to the container and apply rights to the user
COPY . $APP_HOME/
RUN chown -hR doctor:doctor /home/doctor/

# Move to the application folder
WORKDIR $APP_HOME

# Use custom user
USER doctor

# Install Bundler dependencies
RUN bundle config
RUN bundle install

# Install local NPM dependencies
RUN npm install

EXPOSE 4000

CMD ["bundle", "exec", "jekyll", "build"]
