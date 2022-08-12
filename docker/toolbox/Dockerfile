ARG RUBY_VERSION

FROM ruby:${RUBY_VERSION} AS toolbox

ENV INSTALL_PATH /opt/app

ARG RAILS_VERSION

RUN mkdir -p $INSTALL_PATH
RUN gem install bundler
RUN gem install rails -v ${RAILS_VERSION}

WORKDIR $INSTALL_PATH

CMD ["/bin/sh"]