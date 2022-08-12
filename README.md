
```bash 
docker build -t toolbox -f docker/toolbox/Dockerfile .
docker run -it -v $PWD:/opt/app toolbox rails new --skip-bundle dahora
```