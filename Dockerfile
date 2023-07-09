FROM ruby:3.2.1

# set up workdir
RUN mkdir /circuitverse
WORKDIR /circuitverse

# install dependencies
RUN apt-get update -qq && apt-get install -y imagemagick shared-mime-info libvips && apt-get clean

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash \
 && apt-get update && apt-get install -y nodejs && rm -rf /var/lib/apt/lists/* \
 && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
 && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
 && apt-get update && apt-get install -y yarn && rm -rf /var/lib/apt/lists/* \
 && apt-get update && apt-get -y install cmake && rm -rf /var/lib/apt/lists/*

# switch to non-root user
ARG USER_ID
ARG GROUP_ID

RUN addgroup --gid ${GROUP_ID} circuitverse
RUN adduser --disabled-password --gecos '' --uid ${USER_ID} --gid ${GROUP_ID} circuitverse
USER circuitverse

# Install bundler and gems
RUN gem install bundler
RUN bundle config set jobs $(nproc)
RUN bundle config set --local without 'production'

# Expose port
EXPOSE 3000
EXPOSE 3001