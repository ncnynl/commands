FROM ubuntu:22.04
MAINTAINER ncnynl <1043931@qq.com>
RUN mkdir /commands && mkdir -p /tools/commands 
COPY rcmd.sh . 
RUN apt-get update \
    && apt-get install -y git rsync gettext wget \
    && bash ./rcmd.sh \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* \
ENTRYPOINT ["/bin/bash"]