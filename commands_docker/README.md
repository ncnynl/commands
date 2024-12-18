
# install docker 

```

```

# compose run
```
cd commands_extra/docker 

# 构建镜像
$ docker-compose build

# 运行镜像
$ docker-compose up

# 若是要后台运行： 
$ docker-compose up -d
```

# build 
```
cd commands_extra
docker build -t rcm:latest .
```


# run local
```
#使用docker里面的命令集
docker run -it rcm:latest  #进入终端

#使用本机的命令集
docker run -it -v /commands:/commands -v /tools/commands:/tools/commands rcm:latest  
```

# run docker-hub

```
docker run -it ncnynl/rcm:latest
```


# ls
```
# 列出所有的镜像
docker images
```

# rm
```
# 删除某个ID的镜像
sudo docker image rm ID -f
```


# upload images

```
docker login -u ncnynl 
docker tag rcm:latest ncnynl/rcm:latest
docker push ncnynl/rcm:latest
```
