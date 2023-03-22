FROM ruby:2.7.4

RUN apt-get update && \
  apt-get install -y \
  postgresql-client \
  build-essential \
  libpq-dev \
  libxml2-dev \
  libxslt1-dev \
  nodejs \
  npm \
  curl \
  gnupg \
  wget \
  libffi-dev \
  libreadline-dev \
  file \
  imagemagick \
  git \
  tzdata \
  libgmp-dev

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update \
  && apt-get install -y yarn

WORKDIR /app
COPY . /app/

RUN gem install nokogiri --platform=ruby -- --use-system-libraries
RUN npm install
RUN bundle install

ENTRYPOINT [ "bin/rails" ]
EXPOSE 3000
CMD ["s", "-b", "0.0.0.0"]
