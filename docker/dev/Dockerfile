FROM ruby:3.1.2 AS api_dev

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg && apt-key add /root/yarn-pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y --no-install-recommends nodejs yarn

ARG INSTALL_PATH
WORKDIR $INSTALL_PATH

COPY . .

RUN gem install rails bundle dotenv
RUN bundle install
RUN yarn install

COPY docker/dev/entrypoint.sh /usr/bin
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]