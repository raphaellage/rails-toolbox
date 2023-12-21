
build_toolbox () {
  docker build -t toolbox --build-arg RUBY_VERSION --build-arg RAILS_VERSION .
}

create_project () {
  docker run -it -v $PROJECT_FOLDER/:/opt/app toolbox rails new --skip-bundle $PROJECT_NAME --api -d $DB_HOST
  sudo chown -R $MACHINE_USER:$MACHINE_GROUP $PROJECT/
}

prepare_project () {
  cp .env $PROJECT/.env
  [ -d $PROJECT/docker ] || mkdir $PROJECT/docker
  cp -a ./docker/dev/. $PROJECT/docker/dev/
  cp -a ./docker/nginx/. $PROJECT/docker/nginx/

  [ -d $PROJECT/docker/mysql ] || mkdir $PROJECT/docker/mysql

  touch $PROJECT/docker/mysql/init.sql
  envsubst < ./docker/mysql/init.sql > $PROJECT/docker/mysql/init.sql
  
  cp docker/docker-compose.yml $PROJECT/docker-compose.yml
  cp config/database.yml $PROJECT/config/database.yml
  echo ".env" >> $PROJECT/.gitignore
}

if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs -d '\r')
fi

PROJECT="$PROJECT_FOLDER/$PROJECT_NAME"

case $1 in
  build )
    echo "Building toolbox with image ruby:$RUBY_VERSION"
    build_toolbox
    echo "Done building the toolbox";;
  create )
    echo "Creating rails project with Rails:$RAILS_VERSION"
    create_project
    echo "Done creatin the rails project";;
  prepare )
    echo "Preparing configuration files to start the container"
    prepare_project
    echo "Done preparing the configuration files";;
  install )
      echo "Building toolbox with image ruby:$RUBY_VERSION"
      build_toolbox
      echo "Done building the toolbox"
      echo "Creating rails project with Rails:$RAILS_VERSION"
      create_project
      echo "Done creatin the rails project"
      echo "Preparing configuration files to start the container"
      prepare_project
      echo "Done preparing the configuration files";;
esac