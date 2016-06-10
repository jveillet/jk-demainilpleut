FROM ruby:2.2.4-slim

 # Define local mirror (if this one fail, just change http://ftp2.fr to http://ftp2.de)
 RUN echo "deb http://security.debian.org/ jessie/updates main contrib non-free" > /etc/apt/sources.list
 RUN echo "deb-src http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list
 RUN echo "deb http://ftp2.fr.debian.org/debian/ jessie main contrib non-free" >> /etc/apt/sources.list
 RUN echo "deb-src http://ftp2.fr.debian.org/debian/ jessie main contrib non-free" >> /etc/apt/sources.list

 RUN apt-get clean && apt-get update -y \
 		&& apt-get install -y --no-install-recommends git-core build-essential sudo libffi-dev libxml2-dev libssl-dev python imagemagick libmagickwand-dev \
 		&& rm -rf /var/lib/apt/lists/*

 # Add doctor user to sudo group
 RUN groupadd -f -g 1001 doctor
 RUN useradd -m -u 1001 -g doctor doctor
 RUN echo '%doctor ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

 RUN mkdir -p /app
 RUN mkdir -p /bundle

 WORKDIR /app

 COPY Gemfile /app/
 COPY Gemfile.lock /app/

 # Give access to doctor user
 RUN chown -R doctor:doctor /app
 RUN chown -R doctor:doctor /bundle
 RUN chown -R doctor:doctor /home/doctor

 USER doctor

 # Set bundler config
 ENV BUNDLE_JOBS=10 \
 BUNDLE_PATH=/bundle \
 BUNDLE_APP_CONFIG=/app/.bundle-docker/

 # throw errors if Gemfile has been modified since Gemfile.lock
 RUN bundle config
 RUN bundle install --clean

 COPY . /app/
