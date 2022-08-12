# Dockerfile development version
FROM ruby:3.1.2 AS dahora_dev

# Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg && apt-key add /root/yarn-pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y --no-install-recommends nodejs yarn

# Default directory
ENV INSTALL_PATH /opt/app
RUN mkdir -p $INSTALL_PATH

# Install gems
WORKDIR $INSTALL_PATH

COPY dahora/ $INSTALL_PATH
COPY docker/dev/entrypoint.sh /usr/bin
RUN chmod +x /usr/bin/entrypoint.sh

#RUN rm -rf node_modules vendor
RUN gem install rails dotenv

# Start server
#CMD ["rails", "server", "-b", "0.0.0.0"]
ENTRYPOINT ["entrypoint.sh"]