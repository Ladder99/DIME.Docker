# DIME.Docker
Running DIME in Docker.

```sh
cd ~

# clone repostitory
git clone https://github.com/ladder99/DIME.Docker

# create volumes
mkdir -p volumes/dime/configs
mkdir -p volumes/dime/lua
mkdir -p volumes/dime/python
mkdir -p volumes/dime/logs

# copy artifacts
cp DIME.Docker/nlog.config volumes/dime/nlog.config
cp -r DIME.Docker/Lua/* volumes/dime/lua
cp -r DIME.Docker/Python/* volumes/dime/python
cp -r DIME.Docker/ConfigExample/* volumes/dime/configs

# load image
# email cmisztur@mriiot.com to request access
docker login -u your_dockerhub_username
docker pull ladder99/dime:latest
docker images

# run container
docker run \
   -p 5000:5000 \
   -p 7878:7878 \
   -p 8080:8080 \
   -p 8081:8081 \
   -p 8082:8082 \
   -p 9998:9998 \
   -p 9999:9999 \
   -v ~/volumes/dime/nlog.config:/app/nlog.config \
   -v ~/volumes/dime/configs:/app/Configs \
   -v ~/volumes/dime/lua:/app/Lua \
   -v ~/volumes/dime/python:/app/Python \
   -v ~/volumes/dime/logs:/app/Logs \
   ladder99/dime:latest
```

