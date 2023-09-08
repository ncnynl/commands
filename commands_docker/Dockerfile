# FROM python:3.7
 
# COPY src/ /opt/src
# WORKDIR /opt/src
 
# RUN pip install -r requirements.txt
# CMD ["python", "app.py"]
FROM ubuntu:22.04
MAINTAINER ncnynl <1043931@qq.com>
RUN mkdir /commands && mkdir -p /tools/commands 
COPY rcmd.sh . 
RUN apt-get update \
    && apt-get install -y git rsync gettext \
    && bash ./rcmd.sh \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* \
ENTRYPOINT ["rcm"]