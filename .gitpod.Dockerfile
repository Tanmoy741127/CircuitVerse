FROM gitpod/workspace-postgres

USER root
RUN mkdir -p /workspace/CircuitVerse
WORKDIR /workspace/CircuitVerse

# Install custom tools, runtime, etc. using apt-get
# For example, the command below would install "bastet" - a command line tetris clone:
#

RUN apt-get update \
    && curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list \
    && apt-get update \
    && apt-get install -y redis zlib1g-dev libssl-dev libreadline-dev libyaml-dev  libxml2-dev libxslt1-dev libcurl4-openssl-dev ruby-dev  \
    && apt-get clean && rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*

# COPY dependencies files
COPY Gemfile Gemfile.lock package.json yarn.lock ./

# Install Ruby and Gems
RUN /bin/bash -l -c "rvm autolibs disable \
    && rvm install 3.2.0 \
    && rvm use 3.2.0 \
    && cd /workspace/CircuitVerse \
    && gem install bundler \
    && bundle config set --local without 'production' \
    && bundle install \
    && yarn"