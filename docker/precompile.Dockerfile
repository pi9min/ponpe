# This Dockerfile is made just for testing assets:precompile.
# This image is NOT supposed to work as standalone ponpe-server.
FROM ruby:2.3.0

ADD . /ponpe
WORKDIR /ponpe

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq
RUN apt-get install -y \
  mysql-server

RUN bundle install
RUN cp config/database.yml.sample config/database.yml

CMD ["bundle", "exec", "rake", "assets:precompile"]
