FROM heroku/heroku:16-build

RUN apt-get clean && apt-get update -y \
    && apt-get install -y --no-install-recommends git-core build-essential \
    sudo libffi-dev libxml2-dev libssl-dev curl \
    && rm -rf /var/lib/apt/lists/*

RUN gem install bundler

# Using Debian, as root
# Force install latest version of Nodejs
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -
RUN apt-get install -y nodejs
# install globally Gulp
RUN /usr/bin/npm install -g gulp

# Add doctor user to sudo group
RUN useradd -ms /bin/bash doctor
RUN echo '%doctor ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN mkdir -p /app /bundle

WORKDIR /app

COPY Gemfil* /app/

# Give access to doctor user
RUN chown -R doctor:doctor /app /bundle /home/doctor

USER doctor

 # Set bundler config
ENV BUNDLE_JOBS=10 \
    BUNDLE_PATH=/bundle \
    BUNDLE_APP_CONFIG=/app/.bundle-docker/

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config
RUN bundle install --clean

COPY . /app/
