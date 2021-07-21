FROM ruby:3.0.2

# Environment variables
ENV DEBIAN_FRONTEND noninteractive

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -

RUN apt-get update -y \
    && apt-get install -y \
    apt-transport-https \
    libffi-dev \
    libssl-dev \
    libxml2-dev \
    libcurl4-gnutls-dev \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

RUN gem install bundler --no-document

RUN mkdir -p /app

WORKDIR /app

COPY Gemfile* ./

RUN bundle config
RUN bundle install --jobs 4 --retry 3

COPY package.json package-lock.json ./

# Install Gulp
RUN npm install --global gulp-cli

# Install local NPM dependencies
RUN npm install

EXPOSE 8080

ENTRYPOINT ["bundle", "exec"]

CMD ["jekyll", "build"]
