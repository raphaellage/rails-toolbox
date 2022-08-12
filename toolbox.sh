
build_toolbox () {
  docker build -t toolbox --build-arg RUBY_VERSION --build-arg RAILS_VERSION -f docker/toolbox/Dockerfile .
}

create_project () {
  docker run -it -v $PWD:/opt/app toolbox rails new --skip-bundle dahora
  sudo chown -R nesx:nesx dahora/
  sudo rm -rf dahora/.git
}

prepare_project () {
  cp config/env-example dahora/.env
}

if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs -d '\r')
fi

case $1 in
  build )
    echo "Building toolbox with image ruby:$RUBY_VERSION"
    build_toolbox;;
  create )
    echo "Creating rails project with Rails:$RAILS_VERSION"
    create_project;;
  prepare )
    echo "Preparing configuration files to start the container"
    prepare_project;;
esac