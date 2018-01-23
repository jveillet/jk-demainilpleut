FROM heroku/heroku:16

# Environment variables
ENV APP_HOME=/home/app
ENV RACK_ENV=development
ENV JEKYLL_ENV=development

# Create the home directory for the new app user.
RUN mkdir -p $APP_HOME

# Copy the files needed for bundler and NPM
ADD Gemfile $APP_HOME/
ADD Gemfile.lock $APP_HOME/
ADD package*.json $APP_HOME/
ADD .env $APP_HOME/

# Install essentials softwares whith dev headers
RUN apt-get clean && apt-get update -y \
    && apt-get install -y --no-install-recommends build-essential dh-autoreconf ruby2.3-dev \
    sudo libffi-dev libxml2-dev libssl-dev \
    && curl -sL https://deb.nodesource.com/setup_7.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/* \
    && gem install bundler --no-ri --no-rdoc

# Install global dependencies
RUN cd $APP_HOME ; bundle install
RUN cd $APP_HOME ; npm install --global gulp-cli

# Run the image as a non-root user
# Create an app user so our program doesn't run as root.
RUN groupadd -r doctor &&\
    useradd -r -g doctor -d $APP_HOME -s /sbin/nologin -c "Docker image user" doctor

ADD . $APP_HOME

# Chown all the files to the app user.
RUN chown -R doctor:doctor $APP_HOME/

USER doctor

WORKDIR $APP_HOME

# Install local NPM dependencies
RUN npm install --quiet

CMD bundle exec jekyll build
