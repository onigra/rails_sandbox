# syntax = docker/dockerfile:experimental

FROM ruby:2.6.6-alpine as builder

RUN apk --update --no-cache add shadow sudo busybox-suid mariadb-connector-c-dev tzdata alpine-sdk

WORKDIR /rails

COPY Gemfile Gemfile.lock ./
RUN bundle install -j $(getconf _NPROCESSORS_ONLN) --without test development

FROM ruby:2.6.6-alpine

# railsが起動する最低限のものにする
RUN apk --update --no-cache add shadow sudo busybox-suid execline tzdata mariadb-connector-c-dev && \
  cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
  apk del --purge tzdata

WORKDIR /rails

# bundle installしたファイルはbuilderからコピーしてくる
COPY --from=builder /usr/local/bundle /usr/local/bundle

COPY . /rails

EXPOSE 3000
ENTRYPOINT ["docker/entrypoint.sh"]
CMD exec bundle exec puma -e ${RAILS_ENV} -C config/puma.rb
