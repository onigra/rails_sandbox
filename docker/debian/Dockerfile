# syntax = docker/dockerfile:experimental

FROM ruby:2.6.6-slim-buster as builder

RUN apt update && \
  apt install -y default-mysql-client libmariadb-dev build-essential

WORKDIR /rails

COPY Gemfile Gemfile.lock ./
RUN bundle install -j $(getconf _NPROCESSORS_ONLN) --without test development

FROM ruby:2.6.6-slim-buster

# railsが起動する最低限のものにする
RUN apt update && apt install -y default-mysql-client

WORKDIR /rails

# bundle installしたファイルはbuilderからコピーしてくる
COPY --from=builder /usr/local/bundle /usr/local/bundle

COPY . /rails

EXPOSE 3000
ENTRYPOINT ["docker/entrypoint.sh"]
CMD exec bundle exec puma -e ${RAILS_ENV} -C config/puma.rb
