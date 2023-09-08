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
docker run -v /commands:/commands -v /tools/commands:/tools/commands rcm 
docker run rcm:v1 rcm system check_ace
```


# ls
```
docker images
```

# rm
```
sudo docker image rm ID -f
```


