<!-- https://blog.csdn.net/pushiqiang/article/details/78682323 -->


# install docker 

```

```

# compose run
```
cd commands_extra/docker 
$ docker-compose up
# 若是要后台运行： $ docker-compose up -d
```

# build 
```
cd commands_extra
docker build -t rcm:v1 .
```


# run
```
#使用docker里面的命令集
docker run -it rcm:v1  #进入终端
#使用本机的命令集
docker run -it -v /commands:/commands -v /tools/commands:/tools/commands rcm:v1  
```


# ls
```
docker images
```

# rm
```
sudo docker image rm ID -f
```


